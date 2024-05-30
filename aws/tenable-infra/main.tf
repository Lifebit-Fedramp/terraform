locals {
  user_data = <<-EOT
    #!/bin/bash
    echo "Configuring Nessus Agent"
    sudo /opt/nessus_agent/sbin/nessuscli agent link --key=1ac657154e51f5630b1b6010fd1219adac4a8135a4194abf27cc6ade5aa20506 --cloud
    sudo systemctl start nessusagent
    sudo systemctl enable nessusagent

    echo "Configuring Nessus Scanner"
    sudo /opt/nessus/sbin/nessuscli managed link --key=1ac657154e51f5630b1b6010fd1219adac4a8135a4194abf27cc6ade5aa20506 --cloud
  EOT
}

data "aws_partition" "this" {}

data "aws_caller_identity" "this" {}

module "kms" {
  source      = "terraform-aws-modules/kms/aws"
  version     = "3.0.0"
  aliases     = ["key_pair_kms_key"]
  create      = var.create_key_pair
  description = "KMS key to encrypt secrets for Key Pair"
  key_statements = [
    {
      sid = "SecretsManagerAccess"
      actions = [
        "kms:Encrypt*",
        "kms:Decrypt*",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*",
        "kms:Describe*"
      ],
      resources = ["*"]

      principals = [
        {
          type        = "AWS"
          identifiers = ["arn:${data.aws_partition.current.partition}:iam::${data.aws_caller_identity.current.account_id}:root"]
        }
      ]
    }
  ]

  key_usage = "ENCRYPT_DECRYPT"
}

module "key_pair" {
  source                = "terraform-aws-modules/key-pair/aws"
  version               = "2.0.3"
  create                = var.create_key_pair
  create_private_key    = true
  key_name              = var.key_name
  private_key_algorithm = "ED25519"
}

module "key_pair_secret" {
  source  = "terraform-aws-modules/secrets-manager/aws"
  version = "1.1.1"

  block_public_policy = true
  create              = var.create_key_pair
  create_policy       = true
  description         = "KMS key pair secret for ${var.key_name} key pair"
  kms_key_id          = module.kms.key_id
  name                = "${var.key_name}-key-pair-secret"
  policy_statements = {
    read = {
      sid = "AllowAccountRead"
      principals = [{
        type        = "AWS"
        identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
      }]
      actions   = ["secretsmanager:GetSecretValue"]
      resources = ["*"]
    }
  }

  recovery_window_in_days = 7

  secret_string = jsonencode({
    key_pair_id                   = module.key_pair.key_pair_id
    key_pair_arn                  = module.key_pair.arn
    key_pair_name                 = module.key_pair.key_name
    key_pair_fingerprint          = module.key_pair.fingerprint
    private_key_id                = module.key_pair.id
    private_key_openssh           = trimspace(module.key_pair.private_key_openssh)
    private_key_pem               = trimspace(module.key_pair.private_key_pem)
    public_key_fingerprint_md5    = module.key_pair.public_key_fingerprint_md5
    public_key_fingerprint_sha256 = module.key_pair.public_key_fingerprint_sha256
    public_key_openssh            = trimspace(module.key_pair.public_key_openssh)
    public_key_pem                = trimspace(module.key_pair.public_key_pem)
  })
}

module "ec2_instance" {
  source                      = "terraform-aws-modules/ec2-instance/aws"
  version                     = "5.6.1"
  name                        = var.ec2_instance_name
  ami                         = var.ami_id
  create                      = var.create_key_pair
  create_iam_instance_profile = true
  iam_role_description        = "IAM role for EC2 instance"
  iam_role_policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }

  instance_type               = var.ec2_instance_type
  key_name                    = module.key_pair.key_name
  subnet_id                   = var.subnet_id
  user_data_base64            = base64encode(local.user_data)
  user_data_replace_on_change = true
  vpc_security_group_ids      = var.vpc_security_group_ids
}
