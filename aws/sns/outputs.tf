output "topic_arn" {
  value = aws_sns_topic.event_notifications.arn
}

output "kms_key_id" {
  value = module.sns_kms_key.key_id
}

output "kms_key_arn" {
  value = module.sns_kms_key.key_arn
}
