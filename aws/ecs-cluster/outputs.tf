################################################################################
# Security Group
################################################################################

output "security_group_arn" {
  description = "The ARN of the security group"
  value       = module.autoscaling_sg.security_group_arn
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = module.autoscaling_sg.security_group_id
}

output "security_group_vpc_id" {
  description = "The VPC ID"
  value       = module.autoscaling_sg.security_group_vpc_id
}

output "security_group_owner_id" {
  description = "The owner ID"
  value       = module.autoscaling_sg.security_group_owner_id
}

output "security_group_name" {
  description = "The name of the security group"
  value       = module.autoscaling_sg.security_group_name
}

output "security_group_description" {
  description = "The description of the security group"
  value       = module.autoscaling_sg.security_group_description
}

################################################################################
# Launch template
################################################################################

output "launch_template_id" {
  description = "The ID of the launch template"
  value       = module.autoscaling.launch_template_id
}

output "launch_template_arn" {
  description = "The ARN of the launch template"
  value       = module.autoscaling.launch_template_arn
}

output "launch_template_name" {
  description = "The name of the launch template"
  value       = module.autoscaling.launch_template_name
}

output "launch_template_latest_version" {
  description = "The latest version of the launch template"
  value       = module.autoscaling.launch_template_latest_version
}

output "launch_template_default_version" {
  description = "The default version of the launch template"
  value       = module.autoscaling.launch_template_default_version
}

################################################################################
# Autoscaling group
################################################################################

output "autoscaling_group_id" {
  description = "The autoscaling group id"
  value       = module.autoscaling.autoscaling_group_id
}

output "autoscaling_group_name" {
  description = "The autoscaling group name"
  value       = module.autoscaling.autoscaling_group_name
}

output "autoscaling_group_arn" {
  description = "The ARN for this AutoScaling Group"
  value       = module.autoscaling.autoscaling_group_arn
}

output "autoscaling_group_min_size" {
  description = "The minimum size of the autoscale group"
  value       = module.autoscaling.autoscaling_group_min_size
}

output "autoscaling_group_max_size" {
  description = "The maximum size of the autoscale group"
  value       = module.autoscaling.autoscaling_group_max_size
}

output "autoscaling_group_desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the group"
  value       = module.autoscaling.autoscaling_group_desired_capacity
}

output "autoscaling_group_default_cooldown" {
  description = "Time between a scaling activity and the succeeding scaling activity"
  value       = module.autoscaling.autoscaling_group_default_cooldown
}

output "autoscaling_group_health_check_grace_period" {
  description = "Time after instance comes into service before checking health"
  value       = module.autoscaling.autoscaling_group_health_check_grace_period
}

output "autoscaling_group_health_check_type" {
  description = "EC2 or ELB. Controls how health checking is done"
  value       = module.autoscaling.autoscaling_group_health_check_type
}

output "autoscaling_group_availability_zones" {
  description = "The availability zones of the autoscale group"
  value       = module.autoscaling.autoscaling_group_availability_zones
}

output "autoscaling_group_vpc_zone_identifier" {
  description = "The VPC zone identifier"
  value       = module.autoscaling.autoscaling_group_vpc_zone_identifier
}

output "autoscaling_group_load_balancers" {
  description = "The load balancer names associated with the autoscaling group"
  value       = module.autoscaling.autoscaling_group_load_balancers
}

output "autoscaling_group_target_group_arns" {
  description = "List of Target Group ARNs that apply to this AutoScaling Group"
  value       = module.autoscaling.autoscaling_group_target_group_arns
}

output "autoscaling_group_enabled_metrics" {
  description = "List of metrics enabled for collection"
  value       = module.autoscaling.autoscaling_group_enabled_metrics
}

################################################################################
# Autoscaling group schedule
################################################################################

output "autoscaling_schedule_arns" {
  description = "ARNs of autoscaling group schedules"
  value       = module.autoscaling.autoscaling_schedule_arns
}

################################################################################
# Autoscaling Policy
################################################################################

output "autoscaling_policy_arns" {
  description = "ARNs of autoscaling policies"
  value       = module.autoscaling.autoscaling_policy_arns
}

################################################################################
# IAM Role / Instance Profile
################################################################################

output "iam_role_name" {
  description = "The name of the IAM role"
  value       = module.autoscaling.iam_role_name
}

output "iam_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the IAM role"
  value       = module.autoscaling.iam_role_arn
}

output "iam_role_unique_id" {
  description = "Stable and unique string identifying the IAM role"
  value       = module.autoscaling.iam_role_unique_id
}

output "iam_instance_profile_arn" {
  description = "ARN assigned by AWS to the instance profile"
  value       = module.autoscaling.iam_instance_profile_arn
}

output "iam_instance_profile_id" {
  description = "Instance profile's ID"
  value       = module.autoscaling.iam_instance_profile_id
}

output "iam_instance_profile_unique" {
  description = "Stable and unique string identifying the IAM instance profile"
  value       = module.autoscaling.iam_instance_profile_unique
}


################################################################################
# Cluster
################################################################################

output "arn" {
  description = "ARN that identifies the cluster"
  value       = module.ecs_cluster.arn
}

output "id" {
  description = "ID that identifies the cluster"
  value       = module.ecs_cluster.id
}

output "name" {
  description = "Name that identifies the cluster"
  value       = module.ecs_cluster.name
}

################################################################################
# CloudWatch Log Group
################################################################################

output "cloudwatch_log_group_name" {
  description = "Name of CloudWatch log group created"
  value       = module.ecs_cluster.cloudwatch_log_group_name
}

output "cloudwatch_log_group_arn" {
  description = "ARN of CloudWatch log group created"
  value       = module.ecs_cluster.cloudwatch_log_group_arn
}

################################################################################
# Cluster Capacity Providers
################################################################################

output "cluster_capacity_providers" {
  description = "Map of cluster capacity providers attributes"
  value       = module.ecs_cluster.cluster_capacity_providers
}

################################################################################
# Capacity Provider - Autoscaling Group(s)
################################################################################

output "autoscaling_capacity_providers" {
  description = "Map of autoscaling capacity providers created and their attributes"
  value       = module.ecs_cluster.autoscaling_capacity_providers
}

################################################################################
# Task Execution - IAM Role
# https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_execution_IAM_role.html
################################################################################

output "task_exec_iam_role_name" {
  description = "Task execution IAM role name"
  value       = module.ecs_cluster.task_exec_iam_role_name
}

output "task_exec_iam_role_arn" {
  description = "Task execution IAM role ARN"
  value       = module.ecs_cluster.task_exec_iam_role_arn
}

output "task_exec_iam_role_unique_id" {
  description = "Stable and unique string identifying the task execution IAM role"
  value       = module.ecs_cluster.task_exec_iam_role_unique_id
}