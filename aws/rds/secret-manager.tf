resource "random_id" "id" {
  byte_length = 8
}

resource "random_password" "db_master_pass" {
  length  = 16
  special = false
}

resource "aws_secretsmanager_secret" "db-credentials" {
  name        = "${var.identifier}-db-credentials-${random_id.id.hex}"
  description = "RDS database master credentials for ${var.identifier}"
}

resource "aws_secretsmanager_secret_version" "db-credentials" {
  secret_id = aws_secretsmanager_secret.db-credentials.id
  secret_string = jsonencode(
    {
      database = module.db_instance.db_instance_name
      engine   = var.engine
      host     = module.db_instance.db_instance_endpoint
      password = module.db_instance.db_instance_password
      port     = module.db_instance.db_instance_port
      username = module.db_instance.db_instance_username
    }
  )
}
