################################################################################
# Service
################################################################################

output "id" {
  description = "ARN that identifies the service"
  value       = module.ecs_service.id
}

output "name" {
  description = "Name of the service"
  value       = module.ecs_service.name
}

################################################################################
# IAM Role
################################################################################

output "iam_role_name" {
  description = "Service IAM role name"
  value       = module.ecs_service.iam_role_name
}

output "iam_role_arn" {
  description = "Service IAM role ARN"
  value       = module.ecs_service.iam_role_arn
}

output "iam_role_unique_id" {
  description = "Stable and unique string identifying the service IAM role"
  value       = module.ecs_service.iam_role_unique_id
}

################################################################################
# Container Definition
################################################################################

output "container_definitions" {
  description = "Container definitions"
  value       = module.ecs_service.container_definitions
}

################################################################################
# Task Definition
################################################################################

output "task_definition_arn" {
  description = "Full ARN of the Task Definition (including both `family` and `revision`)"
  value       = module.ecs_service.task_definition_arn
}

output "task_definition_revision" {
  description = "Revision of the task in a particular family"
  value       = module.ecs_service.task_definition_revision
}

output "task_definition_family" {
  description = "The unique name of the task definition"
  value       = module.ecs_service.task_definition_family
}

output "task_definition_family_revision" {
  description = "The family and revision (family:revision) of the task definition"
  value       = module.ecs_service.task_definition_family_revision
}

################################################################################
# Task Execution - IAM Role
# https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_execution_IAM_role.html
################################################################################

output "task_exec_iam_role_name" {
  description = "Task execution IAM role name"
  value       = module.ecs_service.task_exec_iam_role_name
}

output "task_exec_iam_role_arn" {
  description = "Task execution IAM role ARN"
  value       = module.ecs_service.task_exec_iam_role_arn
}

output "task_exec_iam_role_unique_id" {
  description = "Stable and unique string identifying the task execution IAM role"
  value       = module.ecs_service.task_exec_iam_role_unique_id
}

################################################################################
# Tasks - IAM role
# https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-iam-roles.html
################################################################################

output "tasks_iam_role_name" {
  description = "Tasks IAM role name"
  value       = module.ecs_service.tasks_iam_role_name
}

output "tasks_iam_role_arn" {
  description = "Tasks IAM role ARN"
  value       = module.ecs_service.tasks_iam_role_arn
}

output "tasks_iam_role_unique_id" {
  description = "Stable and unique string identifying the tasks IAM role"
  value       = module.ecs_service.tasks_iam_role_unique_id
}

################################################################################
# Task Set
################################################################################

output "task_set_id" {
  description = "The ID of the task set"
  value       = module.ecs_service.task_set_id
}

output "task_set_arn" {
  description = "The Amazon Resource Name (ARN) that identifies the task set"
  value       = module.ecs_service.task_set_arn
}

output "task_set_stability_status" {
  description = "The stability status. This indicates whether the task set has reached a steady state"
  value       = module.ecs_service.task_set_stability_status
}

output "task_set_status" {
  description = "The status of the task set"
  value       = module.ecs_service.task_set_status
}

################################################################################
# Autoscaling
################################################################################

output "autoscaling_policies" {
  description = "Map of autoscaling policies and their attributes"
  value       = module.ecs_service.autoscaling_policies
}

output "autoscaling_scheduled_actions" {
  description = "Map of autoscaling scheduled actions and their attributes"
  value       = module.ecs_service.autoscaling_scheduled_actions
}

################################################################################
# Security Group
################################################################################

output "security_group_arn" {
  description = "Amazon Resource Name (ARN) of the security group"
  value       = module.ecs_service.security_group_arn
}

output "security_group_id" {
  description = "ID of the security group"
  value       = module.ecs_service.security_group_id
}