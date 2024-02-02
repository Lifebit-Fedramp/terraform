data "aws_iam_policy_document" "external_secrets" {
  count   = var.enable_external_secrets ? 1 : 0
  version = "2012-10-17"

  statement {
    effect = "Allow"
    actions = [
      "secretsmanager:GetResourcePolicy",
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret",
      "secretsmanager:ListSecretVersionIds"
    ]
    resources = [
      "*"
    ]
  }

  statement {
    effect = "Allow"
    sid    = "AllowDecryptofSharedServicesKey"
    actions = [
      "kms:Decrypt"
    ]
    resources = ["<arn>"] # alias/secrets-manager-key in Shared account
  }
}

resource "aws_iam_policy" "external_secrets_operator" {
  count  = var.enable_external_secrets ? 1 : 0
  name   = "external-secrets-operator"
  policy = data.aws_iam_policy_document.external_secrets[count.index].json
}

data "aws_iam_policy_document" "cluster_autoscaler" {
  count   = var.enable_cluster_autoscaler_oidc ? 1 : 0
  version = "2012-10-17"

  statement {
    effect = "Allow"
    actions = [
      "autoscaling:DescribeAutoScalingGroups",
      "autoscaling:DescribeAutoScalingInstances",
      "autoscaling:DescribeLaunchConfigurations",
      "autoscaling:DescribeScalingActivities",
      "autoscaling:DescribeTags",
      "ec2:DescribeInstanceTypes",
      "ec2:DescribeLaunchTemplateVersions",
      "autoscaling:SetDesiredCapacity",
      "autoscaling:TerminateInstanceInAutoScalingGroup",
      "ec2:DescribeImages",
      "ec2:GetInstanceTypesFromInstanceRequirements",
      "eks:DescribeNodegroup"
    ]
    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "cluster_autoscaler" {
  count  = var.enable_cluster_autoscaler_oidc ? 1 : 0
  name   = "${var.cluster_name}-cluster-autoscaler"
  policy = data.aws_iam_policy_document.cluster_autoscaler[count.index].json
}

data "aws_iam_policy_document" "image_builder_kms" {
  statement {
    sid = "EncryptDecrypt"
    actions = [
      "kms:DescribeKey",
      "kms:ReEncrypt*",
      "kms:CreateGrant",
      "kms:Decrypt",
    ]
    resources = [
      "*"
    ]
    condition {
      test     = "StringLike"
      variable = "kms:RequestAlias"
      values   = ["alias/shared*"]
    }
  }
}

resource "aws_iam_policy" "image_builder_kms" {
  name        = "ImageBuilderKMS"
  path        = "/"
  description = "Allow Encryption operations against image-builder shared AMI"

  policy = data.aws_iam_policy_document.image_builder_kms.json
}
