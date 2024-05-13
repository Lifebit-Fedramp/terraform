################################################################################
# Container Definition
################################################################################

output "container_definition" {
  description = "Container definition"
  value       = { for k, v in module.container_definition : k => v.container_definition }
}

################################################################################
# CloudWatch Log Group
################################################################################

output "cloudwatch_log_group_name" {
  description = "Name of CloudWatch log group created"
  value       = { for k, v in module.container_definition : k => v.cloudwatch_log_group_name }
}

output "cloudwatch_log_group_arn" {
  description = "ARN of CloudWatch log group created"
  value       = { for k, v in module.container_definition : k => v.cloudwatch_log_group_arn }
}

################################################################################
# Secret
################################################################################

output "service_secret" {
  description = "ARN of the secret created for the service"
  value       = { for k, v in aws_secretsmanager_secret.service_secret : k => v.arn }
}