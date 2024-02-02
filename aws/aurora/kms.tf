resource "aws_kms_key" "rds_cloudwatch" {
  deletion_window_in_days = 30
  enable_key_rotation     = true
  policy                  = data.aws_iam_policy_document.rds_cloudwatch_key_policy.json
}

# kics ignore-block
data "aws_iam_policy_document" "rds_cloudwatch_key_policy" {
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
}
