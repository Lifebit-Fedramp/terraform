resource "aws_secretsmanager_secret" "service_secret" {
  for_each = { for k, v in var.container_definitions : k => v if try(v.create_secret, false) }
  name  = "${terraform.workspace}/${var.service_name}/${each.value.name}/ecs-configuration"

  lifecycle {
    ignore_changes = all
  }
}

resource "aws_secretsmanager_secret_version" "secret_version" {
  for_each = { for k, v in var.container_definitions : k => v if try(v.create_secret, false) }
  secret_id     = aws_secretsmanager_secret.service_secret[each.key].id
  secret_string = jsonencode(formatted_secrets)

  lifecycle {
    ignore_changes = all
  }
}

module "container_definition" {
  source  = "terraform-aws-modules/ecs/aws//modules/" # fix
  version = "5.11.1"

  for_each = { for k, v in local.container_definitions : k => v }

  operating_system_family                = try(each.value.operating_system_family, "LINUX")
  command                                = try(each.value.command, [])
  cpu                                    = try(each.value.cpu, null)
  dependencies                           = try(each.value.dependencies, [])
  disable_networking                     = try(each.value.disable_networking, null)
  dns_search_domains                     = try(each.value.dns_search_domains, [])
  dns_servers                            = try(each.value.dns_servers, [])
  docker_labels                          = try(each.value.docker_labels, {})
  docker_security_options                = try(each.value.docker_security_options, [])
  enable_execute_command                 = try(each.value.enable_execute_command, false)
  entrypoint                             = try(each.value.entrypoint, [])
  environment                            = try(each.value.environment, [])
  environment_files                      = try(each.value.environment_files, [])
  essential                              = try(each.value.essential, null)
  extra_hosts                            = try(each.value.extra_hosts, [])
  firelens_configuration                 = try(each.value.firelens_configuration, {})
  health_check                           = try(each.value.health_check, {})
  hostname                               = try(each.value.hostname, null)
  image                                  = try(each.value.image, null)
  interactive                            = try(each.value.interactive, false)
  links                                  = try(each.value.links, [])
  linux_parameters                       = try(each.value.linux_parameters, {})
  log_configuration                      = try(each.value.log_configuration, {})
  memory                                 = try(each.value.memory, null)
  memory_reservation                     = try(each.value.memory_reservation, null)
  mount_points                           = try(each.value.mount_points, [])
  name                                   = try(each.value.name, null)
  port_mappings                          = try(each.value.port_mapping, [])
  pseudo_terminal                        = try(each.value.pseudo_terminal, false)
  repository_credentials                 = try(each.value.repository_credentials, {})
  resource_requirements                  = try(each.value.resource_requirements, [])
  secrets                                = try(each.value.secrets, [])
  start_timeout                          = try(each.value.start_timeout, 30)
  stop_timeout                           = try(each.value.stop_timeout, 120)
  system_controls                        = try(each.value.system_controls, [])
  ulimits                                = try(each.value.ulimits, [])
  user                                   = try(each.value.user, null)
  volumes_from                           = try(each.value.volumes_from, [])
  working_directory                      = try(each.value.working_directory, null)
  service                                = var.service_name
  enable_cloudwatch_logging              = try(each.value.enable_cloudwatch_logging, true)
  create_cloudwatch_log_group            = try(each.value.create_cloudwatch_log_group, true)
  cloudwatch_log_group_name              = try(each.value.cloudwatch_log_group_name, null)
  cloudwatch_log_group_use_name_prefix   = try(each.value.cloudwatch_log_group_use_name_prefix, false)
  cloudwatch_log_group_retention_in_days = try(each.value.cloudwatch_log_group_retention_in_days, 30)
  cloudwatch_log_group_kms_key_id        = try(each.value.cloudwatch_log_group_kms_key_id, null)

  tags = var.tags
}