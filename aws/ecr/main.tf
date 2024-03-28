variable "name" {
  type        = string
  description = "Repository name"
}

variable "account_ids_with_pull_access" {
  type        = list(string)
  description = "List of AWS account IDs that can pull images from this repository"
  default     = []
}

variable "immutable" {
  type        = bool
  default     = true
  description = "Whether to enable immutable tags for this repository"
}

variable "kms_key_arn" {
  type        = string
  default     = ""
  description = "(Optional) ARN of the KMS key to use for encryption"
}

variable "image_scanning" {
  type        = bool
  default     = true
  description = "Whether to enable image scanning"
}

locals {
  shared_account_id       = "<account>"
  account_list_has_shared_services = contains(var.account_ids_with_pull_access, local.shared_account_id)
  account_ids_with_pull_access     = local.account_list_has_shared_services ? var.account_ids_with_pull_access : concat(var.account_ids_with_pull_access, [local.shared_services_account_id])
  account_arns_with_pull_access    = [for account_id in local.account_ids_with_pull_access : "arn:aws-us-gov:iam::${account_id}:root"]
  tag_immutability                 = var.immutable ? "IMMUTABLE" : "MUTABLE"
}

resource "aws_ecr_repository" "this" {
  name                 = var.name
  image_tag_mutability = local.tag_immutability

  dynamic "encryption_configuration" {
    for_each = var.kms_key_arn == "" ? [true]: []
    content {
      encryption_type = "AES256"
    }
  }

  dynamic "encryption_configuration" {
    for_each = var.kms_key_arn != "" ? [true]: []
    content {
      encryption_type = "KMS"
      kms_key         = var.kms_key_arn
    }
  }

  image_scanning_configuration {
    scan_on_push = var.image_scanning
  }
}

data "aws_iam_policy_document" "this" {
  version = "2008-10-17"
  statement {
    sid = "AllowPushPull"

    principals {
      type        = "AWS"
      identifiers = local.account_arns_with_pull_access
    }

    effect = "Allow"
    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:ListImages"
    ]
  }
}

resource "aws_ecr_repository_policy" "this" {
  repository = aws_ecr_repository.this.name
  policy = data.aws_iam_policy_document.this.json
}

resource "aws_ecr_lifecycle_policy" "expire_old_images" {
  repository = aws_ecr_repository.this.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Expire images older than 365 days",
            "selection": {
                "tagStatus": "untagged",
                "countType": "sinceImagePushed",
                "countUnit": "days",
                "countNumber": 365
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}
