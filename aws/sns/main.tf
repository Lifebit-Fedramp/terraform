module "sns_kms_key" {
  source = "terraform-aws-modules/kms/aws"

  description = "sns kms key"
  key_usage   = "ENCRYPT_DECRYPT"

  enable_key_rotation = true

  key_statements = [
    {
      sid = "SNS"
      actions = [
        "kms:Encrypt*",
        "kms:Decrypt*",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*",
        "kms:Describe*"
      ]
      resources = ["*"]

      principals = [
        {
          type        = "Service"
          identifiers = ["sns.amazonaws.com"]
        },
        {
          type        = "Service"
          identifiers = ["sqs.amazonaws.com"]
        }
      ]
    }
  ]
}

resource "aws_sns_topic" "event_notifications" {
  name              = var.topic_name
  kms_master_key_id = module.sns_kms_key.key_id
}

output "topic_arn" {
  value = aws_sns_topic.event_notifications.arn
}

output "kms_key_id" {
  value = module.sns_kms_key.key_id
}

output "kms_key_arn" {
  value = module.sns_kms_key.key_arn
}
