locals {

  formatted_secrets = {
    for container_name, container_config in var.container_definitions :
    container_name => try(container_config.secrets_list, []) != [] ? {
      for name in container_config.secrets_list : name => ""
    } : {}
  }

  container_definitions = {
    for container_name, container_config in var.container_definitions :
    container_name => merge(container_config, {
      secrets = try(container_config.secrets, [for k, v in lookup(local.formatted_secrets, container_name) : {
        name      = k
        valueFrom = "${aws_secretsmanager_secret.service_secret[container_name].arn}:${k}::"
      }])
    })
  }
}