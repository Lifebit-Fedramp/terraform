module "redshift_kms_key" {
  source  = "terraform-aws-modules/kms/aws"
  version = "1.5.0"

  description = "${local.redshift_cluster_name} Redshift cluster encryption"
  key_usage   = "ENCRYPT_DECRYPT"

  enable_key_rotation = true

  key_administrators = [var.key_administrator_arn]
  key_users          = []

  aliases = ["redshift/${local.redshift_cluster_name}"]
}
