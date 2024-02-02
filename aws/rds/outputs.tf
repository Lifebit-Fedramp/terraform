output "db_endpoint" {
  value = module.db_instance.db_instance_endpoint
}

output "db_master_password" {
  sensitive = true
  value     = module.db_instance.db_instance_password
}

output "db_master_username" {
  value = module.db_instance.db_instance_username
}

output "db_name" {
  value = module.db_instance.db_instance_name
}

output "db_port" {
  value = module.db_instance.db_instance_port
}

output "secrets_manager_secret_name" {
  value = aws_secretsmanager_secret.db-credentials.name
}
