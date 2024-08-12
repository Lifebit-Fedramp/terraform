data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_iam_policy_document" "logs_policy" {
  statement {
    effect = "Allow"

    actions = [
      "logs:PutRetentionPolicy"
    ]

    resources = [
      "arn:aws-us-gov:logs:${data.aws_region.current.id}:${data.aws_caller_identity.current.id}:*"
    ]
  }
}