output "db_endpoint" {
  value = aws_rds_cluster.cluster.endpoint
}

output "db_name" {
  value = var.db_name
}

output "db_master_username" {
  value = aws_rds_cluster.cluster.master_username
}

output "db_master_password" {
  sensitive = true
  value     = aws_rds_cluster.cluster.master_password
}

output "db_port" {
  value = aws_rds_cluster.cluster.port
}

output "secrets_manager_secret_name" {
  value = aws_secretsmanager_secret.db-credentials.name
}

output "secrets_manager_secret_arn" {
  value = aws_secretsmanager_secret.db-credentials.arn
}