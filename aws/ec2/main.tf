data "aws_partition" "this" {}

data "aws_caller_identity" "this" {}

resource "aws_ebs_encryption_by_default" "this" {
  enabled = true
}

resource "aws_ebs_default_kms_key" "default_ebs_encryption" {
  count   = var.use_default_key ? 0 : 1
  key_arn = var.kms_key_arn
}

resource "aws_kms_grant" "cross_org_grant" {
  count = var.kms_key_arn == null ? 0 : 1

  name              = "CrossAccountSharing"
  key_id            = var.kms_key_arn
  grantee_principal = "arn:${data.aws_partition.this.id}:iam::${data.aws_caller_identity.this.account_id}:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"
  operations        = ["Encrypt", "Decrypt", "GenerateDataKeyWithoutPlaintext", "ReEncryptFrom", "ReEncryptTo", "CreateGrant", "GenerateDataKey", "DescribeKey"]
}
