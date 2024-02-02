variable "name" {
  description = "Name of the resource"
  type        = string
}

variable "description" {
  description = "Description of the resource"
  type        = string
}

variable "kms_key_id" {
  description = "ID or ARN of KMS Key used to encrypt"
  type        = string
  default     = ""
}

variable "allow_cross_account_access" {
  description = "Boolean for whether to use KMS key encryption"
  type        = bool
  default     = false
}

variable "account_role_arn_list" {
  description = "List of Account ARNs with access to Secret"
  type        = list(string)
  default     = [""] # Defaults to no permissions
}

resource "aws_secretsmanager_secret" "this" {
  name        = var.name
  description = var.description
  kms_key_id  = var.allow_cross_account_access == true ? var.kms_key_id : null
}

data "aws_iam_policy_document" "this" {
  count = var.allow_cross_account_access == true ? 1 : 0
  statement {
    sid    = "EnableAnotherAWSAccountToReadSecret"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = var.account_role_arn_list
    }

    actions   = ["secretsmanager:GetSecretValue"]
    resources = ["*"]
  }
}

resource "aws_secretsmanager_secret_policy" "this" {
  count      = var.allow_cross_account_access == true ? 1 : 0
  secret_arn = aws_secretsmanager_secret.this.arn

  policy = data.aws_iam_policy_document.this[0].json
}

output "secret_id" {
  value = aws_secretsmanager_secret.this.id
}
