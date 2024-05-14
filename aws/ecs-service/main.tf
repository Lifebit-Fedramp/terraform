resource "aws_secretsmanager_secret" "service_secret" {
  for_each = { for k, v in var.container_definitions : k => v if try(v.secrets_list, []) != [] }
  name  = "${terraform.workspace}/${var.name}/${each.value.name}/ecs-configuration"

  lifecycle {
    ignore_changes = all
  }
}

resource "aws_secretsmanager_secret_version" "secret_version" {
  for_each = { for k, v in var.container_definitions : k => v if try(v.secrets_list, []) != [] }
  secret_id     = aws_secretsmanager_secret.service_secret[each.key].id
  secret_string = jsonencode(local.formatted_secrets)

  lifecycle {
    ignore_changes = all
  }
}

resource "aws_lb_target_group" "service_tg" {
  count       = var.create ? 1 : 0
  name        = "${var.name}-tg"
  port        = var.app_port
  protocol    = var.tg_protocol
  vpc_id      = var.vpc_id
  target_type = var.target_type

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    path                = var.health_check_path
    protocol            = var.tg_protocol
    matcher             = "200"
    interval            = 30
  }
}

resource "aws_lb_listener_rule" "service_rule" {
  count        = var.create ? 1 : 0
  listener_arn = var.listener_arn
  priority     = var.rule_priority

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.service_tg[0].arn
  }

  condition {
    path_pattern {
      values = var.path_pattern
    }
  }
}

module "ecs_service" {
  source  = "terraform-aws-modules/ecs/aws//modules/service"
  version = "5.11.1"
  create  = var.create

  # Service
  ignore_task_definition_changes = var.ignore_task_definition_changes
  alarms                         = var.alarms
  #  capacity_provider_strategy         = var.capacity_provider_strategy
  cluster_arn                        = var.cluster_arn
  deployment_circuit_breaker         = var.deployment_circuit_breaker
  deployment_controller              = var.deployment_controller
  deployment_maximum_percent         = var.deployment_maximum_percent
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
  desired_count                      = var.desired_count
  enable_ecs_managed_tags            = var.enable_ecs_managed_tags
  enable_execute_command             = var.enable_execute_command
  force_new_deployment               = var.force_new_deployment
  health_check_grace_period_seconds  = var.health_check_grace_period_seconds
  launch_type                        = "EC2"
  load_balancer                      = {
    service = {
      target_group_arn = aws_lb_target_group.service_tg[0].arn
      container_name   = var.container_name
      container_port   = var.app_port
    }
  }
  name                               = var.name
  security_group_ids                 = var.security_group_ids
  subnet_ids                         = var.subnet_ids
  placement_constraints              = var.placement_constraints
  platform_version                   = var.platform_version
  propagate_tags                     = var.propagate_tags
  scheduling_strategy                = var.scheduling_strategy
  service_connect_configuration      = var.service_connect_configuration
  service_registries                 = var.service_registries
  timeouts                           = var.timeouts
  triggers                           = var.triggers
  wait_for_steady_state              = var.wait_for_steady_state
  service_tags                       = var.service_tags

  # Service - IAM Role
  create_iam_role               = var.create_iam_role
  iam_role_arn                  = var.iam_role_arn
  iam_role_name                 = var.iam_role_name
  iam_role_use_name_prefix      = var.iam_role_use_name_prefix
  iam_role_path                 = var.iam_role_path
  iam_role_description          = var.iam_role_description
  iam_role_permissions_boundary = var.iam_role_permissions_boundary
  iam_role_tags                 = var.iam_role_tags
  iam_role_statements           = var.iam_role_statements

  # Task Definition
  create_task_definition                = var.create_task_definition
  task_definition_arn                   = var.task_definition_arn
  container_definitions                 = local.container_definitions
  container_definition_defaults         = var.container_definition_defaults
  cpu                                   = var.cpu
  ephemeral_storage                     = var.ephemeral_storage
  family                                = var.family
  inference_accelerator                 = var.inference_accelerator
  ipc_mode                              = var.ipc_mode
  memory                                = var.memory
  network_mode                          = var.network_mode
  pid_mode                              = var.pid_mode # task not host?
  task_definition_placement_constraints = var.task_definition_placement_constraints
  proxy_configuration                   = var.proxy_configuration
  requires_compatibilities              = var.requires_compatibilities
  runtime_platform                      = var.runtime_platform
  skip_destroy                          = var.skip_destroy
  volume                                = var.volume
  task_tags                             = var.task_tags

  # Task Execution - IAM Role
  create_task_exec_iam_role               = var.create_task_exec_iam_role
  task_exec_iam_role_arn                  = var.task_exec_iam_role_arn
  task_exec_iam_role_name                 = var.task_exec_iam_role_name
  task_exec_iam_role_use_name_prefix      = var.task_exec_iam_role_use_name_prefix
  task_exec_iam_role_path                 = var.task_exec_iam_role_path
  task_exec_iam_role_description          = var.task_exec_iam_role_description
  task_exec_iam_role_permissions_boundary = var.task_exec_iam_role_permissions_boundary
  task_exec_iam_role_tags                 = var.task_exec_iam_role_tags
  task_exec_iam_role_policies             = var.task_exec_iam_role_policies
  create_task_exec_policy                 = var.create_task_exec_policy
  task_exec_ssm_param_arns                = var.task_exec_ssm_param_arns
  task_exec_secret_arns                   = [for k, v in aws_secretsmanager_secret.service_secret : v.arn]
  task_exec_iam_statements                = var.task_exec_iam_statements

  # Tasks - IAM Role
  create_tasks_iam_role               = var.create_tasks_iam_role
  tasks_iam_role_arn                  = var.tasks_iam_role_arn
  tasks_iam_role_name                 = var.tasks_iam_role_name
  tasks_iam_role_use_name_prefix      = var.tasks_iam_role_use_name_prefix
  tasks_iam_role_path                 = var.tasks_iam_role_path
  tasks_iam_role_description          = var.tasks_iam_role_description
  tasks_iam_role_permissions_boundary = var.tasks_iam_role_permissions_boundary
  tasks_iam_role_tags                 = var.tasks_iam_role_tags
  tasks_iam_role_policies             = var.tasks_iam_role_policies
  tasks_iam_role_statements           = var.tasks_iam_role_statements

  # Task Set
  external_id               = var.external_id
  scale                     = var.scale
  force_delete              = var.force_delete
  wait_until_stable         = var.wait_until_stable
  wait_until_stable_timeout = var.wait_until_stable_timeout

  # Autoscaling
  enable_autoscaling            = var.enable_autoscaling
  autoscaling_min_capacity      = var.autoscaling_min_capacity
  autoscaling_max_capacity      = var.autoscaling_max_capacity
  autoscaling_policies          = var.autoscaling_policies
  autoscaling_scheduled_actions = var.autoscaling_scheduled_actions

  # Security Group

  # use ecs cluster sv?
  create_security_group          = var.create_security_group
  security_group_name            = var.security_group_name
  security_group_use_name_prefix = var.security_group_use_name_prefix
  security_group_description     = var.security_group_description
  security_group_rules           = var.security_group_rules
  security_group_tags            = var.security_group_tags

  ordered_placement_strategy = [
    {
      type  = "binpack"
      field = "cpu"
    }
  ]

  #  capacity_provider_strategy {
  #    capacity_provider = "${var.cluster_name}_capacity_provider"
  #    weight            = 100
  #    base              = 1
  #  }

  tags = var.tags
}
