data "aws_partition" "current" {}

data "aws_caller_identity" "current" {}

locals {
  user_data = <<-EOT
    #!/bin/bash
    echo "Configuring Nessus Agent"
    # get metadata values
    TOKEN=$(curl -XPUT -s "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
    AVAILABILITY_ZONE=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone -H "X-aws-ec2-metadata-token: $TOKEN")
    REGION=$(echo $AVAILABILITY_ZONE | sed 's/[a-z]$//')
    NESSUS_KEY=$(aws ssm get-parameter --region $REGION --name /NESSUS_KEY --with-decryption | jq -r '.Parameter.Value')
    TENABLE_WAS_NAME=$(aws ssm get-parameter --region $REGION --name /TENABLE_WAS_NAME --with-decryption | jq -r '.Parameter.Value')
    TENABLE_SCANNER_NAME=$(aws ssm get-parameter --region $REGION --name /TENABLE_SCANNER_NAME --with-decryption | jq -r '.Parameter.Value')
  
    echo "Downloading Nessus Agent installation package"
    file=NessusAgent-amzn2.x86_64.rpm
    curl -H "X-Key: $NESSUS_KEY" -s https://sensor.cloud.tenable.com/install/agent/installer/$file -o $file

    echo "Installing and starting Nessus Agent"
    rpm -ivh $file
    systemctl start nessusagent
    systemctl enable nessusagent

    echo "Linking Nessus Agent"
    /opt/nessus_agent/sbin/nessuscli agent link --key=$NESSUS_KEY --cloud

    echo "Downloading Nessus Scanner installation package"
    scanner_file=Nessus-amzn2.x86_64.rpm
    curl -H "X-Key: $NESSUS_KEY" -s https://sensor.cloud.tenable.com/install/scanner/installer/$file -o $scanner_file

    echo "Setup scanner config"
    CONFIGURATION='{"link":{"host":"sensor.cloud.tenable.com","port":443,"key":"NESSUS_KEY","name":"SCANNER_NAME","groups":["SharedVPC"]}}'
    echo $CONFIGURATION > /opt/nessus/var/nessus/config.json
    sed -i "s/NESSUS_KEY/$NESSUS_KEY/g" /opt/nessus/var/nessus/config.json
    sed -i "s/SCANNER_NAME/$TENABLE_SCANNER_NAME/g" /opt/nessus/var/nessus/config.json

    echo "Link Nessus Scanner"
    /opt/nessus/sbin/nessuscli managed link --key=$NESSUS_KEY --cloud --name=$TENABLE_SCANNER_NAME

    echo "Installing and starting Nessus Scanner Service"
    rpm -ivh $scanner_file
    systemctl start nessusd
    systemctl enable nessusd

    echo "Installing Nessus WAS"
    aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin 026589913916.dkr.ecr-fips.$REGION.amazonaws.com
    docker pull 026589913916.dkr.ecr-fips.$REGION.amazonaws.com/tenable-was:0.1.0
    docker tag 026589913916.dkr.ecr-fips.$REGION.amazonaws.com/tenable-was:0.1.0 tenable-was:0.1.0
    docker run -d -e WAS_SCANNER_NAME=$TENABLE_WAS_NAME -e WAS_LINKING_KEY=$NESSUS_KEY --network=host tenable-was:0.1.0 
  EOT
}

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
        type        = "*"
        identifiers = ["*"]
      }]
      actions   = ["secretsmanager:GetSecretValue"]
      resources = ["*"]
      conditions = [{
        test     = "StringEquals"
        variable = "aws:PrincipalOrgID"

        values = [
          "o-uucy43ih83"
        ]
      }]
    }
  }

  recovery_window_in_days = 7

  secret_string = jsonencode({
    key_pair_id                   = module.key_pair.key_pair_id
    key_pair_arn                  = module.key_pair.key_pair_arn
    key_pair_name                 = module.key_pair.key_pair_name
    key_pair_fingerprint          = module.key_pair.key_pair_fingerprint
    private_key_id                = module.key_pair.key_pair_id
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
  ignore_ami_changes          = var.ignore_ami_changes
  create                      = var.create_key_pair
  iam_instance_profile        = aws_iam_instance_profile.tenable.name

  instance_type               = var.ec2_instance_type
  key_name                    = module.key_pair.key_pair_name
  subnet_id                   = var.subnet_id
  user_data_base64            = base64encode(local.user_data)
  user_data_replace_on_change = false
  vpc_security_group_ids      = var.vpc_security_group_ids
}
