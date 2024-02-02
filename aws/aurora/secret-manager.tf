resource "random_id" "id" {
  byte_length = 8
}

# initial password
resource "random_password" "db_master_pass" {
  length  = 16
  special = false
}

resource "aws_secretsmanager_secret" "db-credentials" {
  name        = "${var.db_cluster_identifier}-db-credentials-${random_id.id.hex}"
  description = "RDS database master credentials for ${var.db_cluster_identifier}"
}

resource "aws_secretsmanager_secret_version" "db-credentials" {
  secret_id = aws_secretsmanager_secret.db-credentials.id
  secret_string = jsonencode(
    {
      username            = aws_rds_cluster.cluster.master_username
      password            = aws_rds_cluster.cluster.master_password
      engine              = var.db_engine
      host                = aws_rds_cluster.cluster.endpoint
      port                = aws_rds_cluster.cluster.port
      dbClusterIdentifier = aws_rds_cluster.cluster.cluster_identifier
    }
  )
}
