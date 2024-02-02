resource "aws_kms_key" "this" {
  customer_master_key_spec = var.cmk_encryption
  deletion_window_in_days  = var.deletion_window
  description              = var.description
  enable_key_rotation      = var.rotation_enabled
  is_enabled               = var.key_enabled
  key_usage                = var.key_usage
  multi_region             = var.multi_region
  policy                   = var.policy == null ? data.aws_iam_policy_document.this.json : var.policy

  tags = var.tags
}

resource "aws_kms_alias" "this" {
  name          = var.alias
  name_prefix   = null
  target_key_id = aws_kms_key.this.key_id
}

resource "aws_kms_replica_key" "this" {
  count                   = var.is_replica ? 1 : 0
  deletion_window_in_days = var.deletion_window
  description             = var.description
  enabled                 = var.key_enabled
  policy                  = var.policy == null ? data.aws_iam_policy_document.this.json : var.policy
  primary_key_arn         = var.primary_key_arn
  tags                    = var.tags
}

data "aws_iam_policy_document" "this" {
  statement {
    sid       = "1"
    actions   = ["kms:*"]
    resources = ["*"]

    principals {
      type        = "AWS"
      identifiers = ["arn:${data.aws_partition.current.partition}:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }
}