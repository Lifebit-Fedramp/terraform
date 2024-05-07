resource "aws_iam_policy" "cw_access" {
  name        = "${var.cluster_name}-cloudwatch-logs-policy"
  description = "CloudWatch logs access for ECS"

  policy = data.aws_iam_policy_document.logs_policy.json
}

module "autoscaling_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.2"
  create  = var.create_sg

  name               = var.sg_name
  vpc_id             = var.vpc_id
  use_name_prefix    = var.use_name_prefix_sg
  description        = format("Security group for %s ECS Instances", var.cluster_name)

  computed_ingress_with_source_security_group_id = [for source_sg in var.ingress_source_sgs :
    {
      rule                     = "all-all"
      source_security_group_id = source_sg
    }
  ]
  number_of_computed_ingress_with_source_security_group_id = length(var.ingress_source_sgs)

  egress_rules = ["all-all"]

  tags = merge(var.tags, {
    Name = var.sg_name
  })
}

module "autoscaling" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "7.4.1"
  create  = var.create_asg

  ignore_desired_capacity_changes = true
  name                            = var.asg_name
  use_name_prefix                 = var.use_name_prefix_alb
  instance_name                   = var.instance_name
  launch_template_id              = var.launch_template_id
  launch_template_version         = var.launch_template_version
  vpc_zone_identifier             = var.vpc_zone_identifier
  min_size                        = var.min_size
  max_size                        = var.max_size
  desired_capacity                = var.desired_capacity
  desired_capacity_type           = var.desired_capacity_type
  default_cooldown                = var.default_cooldown
  default_instance_warmup         = var.default_instance_warmup
  protect_from_scale_in           = var.protect_from_scale_in
  placement_group                 = var.placement_group
  health_check_type               = "EC2"
  health_check_grace_period       = var.health_check_grace_period
  force_delete                    = var.force_delete
  termination_policies            = var.termination_policies
  suspended_processes             = var.suspended_processes
  max_instance_lifetime           = var.max_instance_lifetime
  enabled_metrics                 = var.enabled_metrics
  metrics_granularity             = var.metrics_granularity
  service_linked_role_arn         = var.service_linked_role_arn
  initial_lifecycle_hooks         = var.initial_lifecycle_hooks
  instance_refresh                = var.instance_refresh
  mixed_instances_policy          = var.mixed_instances_policy
  delete_timeout                  = var.delete_timeout
  warm_pool                       = var.warm_pool
  ebs_optimized                   = var.ebs_optimized
  image_id                        = var.image_id
  instance_type                   = var.instance_type
  user_data = base64encode(templatefile("${path.module}/${var.instances_user_data_tpl_path}", {
    cluster_name = var.cluster_name
    tags         = var.tags
  }))
  security_groups   = concat(var.security_groups, [module.autoscaling_sg.security_group_id])
  enable_monitoring = var.enable_monitoring
  metadata_options  = var.metadata_options
  autoscaling_group_tags = merge(var.autoscaling_group_tags, {
    AmazonECSManaged = true
  })
  ignore_failed_scaling_activities     = var.ignore_failed_scaling_activities
  instance_maintenance_policy          = var.instance_maintenance_policy
  create_launch_template               = var.create_launch_template
  launch_template_name                 = var.launch_template_name
  launch_template_use_name_prefix      = var.launch_template_use_name_prefix
  launch_template_description          = var.launch_template_description
  default_version                      = var.default_version
  update_default_version               = var.update_default_version
  disable_api_termination              = var.disable_api_termination
  disable_api_stop                     = var.disable_api_stop
  instance_initiated_shutdown_behavior = var.instance_initiated_shutdown_behavior
  block_device_mappings                = var.block_device_mappings
  capacity_reservation_specification   = var.capacity_reservation_specification
  cpu_options                          = var.cpu_options
  maintenance_options                  = var.maintenance_options
  network_interfaces                   = var.network_interfaces
  placement                            = var.placement
  private_dns_name_options             = var.private_dns_name_options
  tag_specifications                   = var.tag_specifications
  create_traffic_source_attachment     = var.create_traffic_source_attachment
  traffic_source_identifier            = var.traffic_source_identifier
  traffic_source_type                  = var.traffic_source_type
  create_schedule                      = var.create_schedule
  schedules                            = var.schedules
  create_iam_instance_profile          = true
  iam_instance_profile_name            = var.iam_instance_profile_name
  iam_role_name                        = var.iam_role_name
  iam_role_use_name_prefix             = var.iam_role_use_name_prefix
  iam_role_path                        = var.iam_role_path
  iam_role_description                 = var.iam_role_description
  iam_role_permissions_boundary        = var.iam_role_permissions_boundary
  iam_role_policies = merge(var.iam_role_policies, {
    AmazonEC2ContainerServiceforEC2Role = "arn:aws-us-gov:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
    AmazonSSMManagedInstanceCore        = "arn:aws-us-gov:iam::aws:policy/AmazonSSMManagedInstanceCore"
    CloudWatchLogAccess                 = aws_iam_policy.cw_access.arn
  })
  iam_role_tags = var.iam_role_tags

  tags = var.tags
}

module "ecs_cluster" {
  source  = "terraform-aws-modules/ecs/aws//modules/cluster"
  version = "5.11.1"
  create  = var.create_ecs_cluster

  # Cluster
  cluster_name                     = var.cluster_name
  cluster_configuration            = var.cluster_configuration
  cluster_settings                 = [
    {
      "name": "containerInsights",
      "value": "enabled"
    }
  ]
  cluster_service_connect_defaults = var.cluster_service_connect_defaults

  # Cluster Cloudwatch log group
  create_cloudwatch_log_group            = var.create_cloudwatch_log_group
  cloudwatch_log_group_name              = var.cloudwatch_log_group_name
  cloudwatch_log_group_retention_in_days = var.cloudwatch_log_group_retention_in_days
  cloudwatch_log_group_kms_key_id        = var.cloudwatch_log_group_kms_key_id
  cloudwatch_log_group_tags              = var.cloudwatch_log_group_tags

  # Cluster capacity providers
  default_capacity_provider_use_fargate = false
  autoscaling_capacity_providers = {
    on_demand = {
      auto_scaling_group_arn         = module.autoscaling.autoscaling_group_arn
      managed_termination_protection = "ENABLED"

      managed_scaling = {
        maximum_scaling_step_size = 5
        minimum_scaling_step_size = 1
        status                    = "ENABLED"
        target_capacity           = 60
      }

      default_capacity_provider_strategy = {
        weight = 60
        base   = 20
      }
    }
  }

  # Task execution IAM role
  create_task_exec_iam_role               = var.create_task_exec_iam_role
  task_exec_iam_role_name                 = var.task_exec_iam_role_name
  task_exec_iam_role_use_name_prefix      = var.task_exec_iam_role_use_name_prefix
  task_exec_iam_role_path                 = var.task_exec_iam_role_path
  task_exec_iam_role_description          = var.task_exec_iam_role_description
  task_exec_iam_role_permissions_boundary = var.task_exec_iam_role_permissions_boundary
  task_exec_iam_role_tags                 = var.task_exec_iam_role_tags
  task_exec_iam_role_policies             = var.task_exec_iam_role_policies

  # Task execution IAM role policy
  create_task_exec_policy  = var.create_task_exec_policy
  task_exec_ssm_param_arns = var.task_exec_ssm_param_arns
  task_exec_secret_arns    = var.task_exec_secret_arns
  task_exec_iam_statements = var.task_exec_iam_statements

  tags = var.tags
}
