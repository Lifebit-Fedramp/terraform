locals {
  is_mysql      = can(regex("mysql", var.db_family))
  is_postgres   = can(regex("postgresql", var.db_family))
  is_serverless = can(regex("db.serverless", var.db_instance_class))

  port_number = local.is_mysql ? 3306 : 5432

  access_cidr_rules = length(var.access_cidrs) == 0 ? null : {
    from_port       = local.port_number
    to_port         = local.port_number
    protocol        = "tcp"
    cidr_blocks     = var.access_cidrs
    self            = null
    security_groups = null
  }

  access_sg_rules = length(var.access_sg_ids) == 0 ? null : {
    from_port       = local.port_number
    to_port         = local.port_number
    protocol        = "tcp"
    cidr_blocks     = null
    self            = null
    security_groups = var.access_sg_ids
  }

  mysql_parameters = [
    {
      name  = "require_secure_transport"
      value = "ON"
    },
    {
      name  = "sql_mode"
      value = "NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION"
    },
    {
      name  = "max_connections"
      value = "16000"
    }
  ]

  postgres_parameters = [
    {
      name  = "rds.force_ssl"
      value = "1"
    }
  ]

  serverlessv2_parameters = [
    {
      max_capacity = var.serverlessv2_max_capacity
      min_capacity = var.serverlessv2_min_capacity
    }
  ]

  security_group_rules_1 = []
  security_group_rules_2 = local.access_cidr_rules != null ? concat(local.security_group_rules_1, [local.access_cidr_rules]) : local.security_group_rules_1
  security_group_rules = local.access_sg_rules != null ? concat(local.security_group_rules_2, [local.access_sg_rules]) : local.security_group_rules_2
}

resource "aws_db_subnet_group" "db" {
  subnet_ids = var.db_subnet_ids
}

resource "aws_rds_cluster_parameter_group" "default" {
  name        = var.db_cluster_identifier
  family      = var.db_family
  description = "Cluster parameter group for ${var.db_cluster_identifier}"

  dynamic "parameter" {
    for_each = local.is_mysql ? local.mysql_parameters : local.postgres_parameters
    content {
      name  = parameter.value.name
      value = parameter.value.value
    }
  }
}

resource "aws_rds_cluster" "cluster" {
  cluster_identifier = var.db_cluster_identifier
  engine             = var.db_engine
  engine_version     = var.db_engine_version

  storage_encrypted   = var.db_storage_encrypted
  deletion_protection = true

  database_name   = var.db_name
  master_username = var.db_master_username
  master_password = random_password.db_master_pass.result

  db_subnet_group_name   = aws_db_subnet_group.db.name
  vpc_security_group_ids = [aws_security_group.aurora.id]

  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.default.name

  db_instance_parameter_group_name = "default.${var.db_family}"

  backup_retention_period = var.backup_retention_period

  skip_final_snapshot = true
  tags                = var.tags

  enabled_cloudwatch_logs_exports = local.is_mysql ? var.mysql_log_types : var.psql_log_types

  dynamic "serverlessv2_scaling_configuration" {
    for_each = local.is_serverless ? local.serverlessv2_parameters : []
    iterator = config
    content {
      max_capacity = config.value.max_capacity
      min_capacity = config.value.min_capacity
    }
  }

  # Prevent the creation of log groups until the cloudwatch resource has created them.
  # This prevents the logs from being created before aforementioned resource is able to.
  depends_on = [
    aws_cloudwatch_log_group.mysql_rds_cluster,
    aws_cloudwatch_log_group.psql_rds_cluster
  ]
}

resource "aws_rds_cluster_instance" "cluster_instances" {
  count              = var.db_instance_count
  identifier         = "${var.db_cluster_identifier}-${count.index}"
  cluster_identifier = aws_rds_cluster.cluster.id
  instance_class     = var.db_instance_class
  engine             = aws_rds_cluster.cluster.engine
  engine_version     = aws_rds_cluster.cluster.engine_version
  tags               = var.tags
}

resource "aws_security_group" "aurora" {
  name   = "${var.db_cluster_identifier}-sg"
  vpc_id = var.vpc_id
  tags   = { "Name" = "${var.db_cluster_identifier}-sg" }


  dynamic "ingress" {
    for_each = local.security_group_rules
    content {
      from_port       = ingress.value.from_port
      to_port         = ingress.value.to_port
      protocol        = ingress.value.protocol
      cidr_blocks     = ingress.value.cidr_blocks
      self            = ingress.value.self
      security_groups = ingress.value.security_groups
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_cloudwatch_log_group" "mysql_rds_cluster" {
  for_each = local.is_mysql ? toset(var.mysql_log_types) : []

  name              = "${var.log_prefix}/${var.db_cluster_identifier}/${each.key}"
  kms_key_id        = aws_kms_key.rds_cloudwatch.arn
  retention_in_days = 365
}

resource "aws_cloudwatch_log_group" "psql_rds_cluster" {
  for_each = local.is_postgres ? toset(var.psql_log_types) : []

  name              = "${var.log_prefix}/${var.db_cluster_identifier}/${each.key}"
  kms_key_id        = aws_kms_key.rds_cloudwatch.arn
  retention_in_days = 365
}

