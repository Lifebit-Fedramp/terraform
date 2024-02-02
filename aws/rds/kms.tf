resource "aws_kms_key" "rds_kms_cmk" {
  deletion_window_in_days = 30
  enable_key_rotation     = true
  policy                  = data.aws_iam_policy_document.rds_kms_cmk_policy.json
}

# kics ignore-block
data "aws_iam_policy_document" "rds_kms_cmk_policy" {
  statement {
    effect = "Allow"
    principals {
      identifiers = [
        "logs.${data.aws_region.current.name}.amazonaws.com"
      ]
      type = "Service"
    }
    actions = [
      "kms:CreateKey",
      "kms:CreateGrant",
      "kms:Decrypt",
      "kms:Describe*",
      "kms:Get*",
      "kms:Encrypt",
      "kms:GenerateDataKey*",
      "kms:ListGrants",
      "kms:ListKey",
      "kms:PutKey",
      "kms:ReEncrypt*",
      "kms:RevokeGrant"
    ]
    resources = [
      "*"
    ]
  }

  statement {
    effect = "Allow"
    principals {
      identifiers = [
        "arn:aws-us-gov:iam::${data.aws_caller_identity.current.account_id}:root",
        "arn:aws-us-gov:iam::${data.aws_caller_identity.current.account_id}:role/<role>"
      ]
      type = "AWS"
    }
    actions   = ["kms:*"]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    principals {
      identifiers = ["*"]
      type        = "AWS"
    }
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:CreateGrant",
      "kms:listGrants",
      "kms:DescribeKey"
    ]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      values   = ["rds.${data.aws_region.current.name}.amazonaws.com"]
      variable = "kms:ViaService"
    }
    condition {
      test     = "StringEquals"
      values   = ["${data.aws_caller_identity.current.account_id}"]
      variable = "kms:CallerAccount"
    }
  }
}
