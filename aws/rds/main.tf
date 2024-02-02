data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

resource "aws_db_subnet_group" "db" {
  subnet_ids = var.subnet_ids
}

module "db_instance" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 5.6.0"

  identifier           = var.db_identifier
  engine               = var.db_engine
  engine_version       = var.db_engine_version
  family               = var.db_family
  major_engine_version = var.major_engine_version
  instance_class       = var.instance_class
  db_name              = var.db_name

  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_type          = var.storage_type

  storage_encrypted = true
  kms_key_id        = aws_kms_key.rds_kms_cmk.arn

  username               = var.db_master_username
  create_random_password = false
  password               = random_password.db_master_pass.result
  port                   = var.port

  multi_az               = var.multi_az
  publicly_accessible    = var.publicly_accessible
  subnet_ids             = var.subnet_ids
  create_db_subnet_group = false
  db_subnet_group_name   = aws_db_subnet_group.db.name
  vpc_security_group_ids = [aws_security_group.rds.id]

  maintenance_window      = var.maint_window
  apply_immediately       = var.apply_immediately
  copy_tags_to_snapshot   = true
  backup_window           = var.backup_window
  backup_retention_period = var.backup_retention_period
  skip_final_snapshot     = false
  deletion_protection     = true

  option_group_use_name_prefix = false

  create_cloudwatch_log_group     = true
  cloudwatch_log_group_kms_key_id = aws_kms_key.rds_kms_cmk.arn
  enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]

  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_kms_key_id       = aws_kms_key.rds_kms_cmk.arn
  performance_insights_retention_period = var.performance_insights_retention_period
  create_monitoring_role                = true
  monitoring_role_name                  = "rds-${var.db_identifier}-monitoring-role"
  monitoring_interval                   = var.monitoring_interval

  create_db_parameter_group = true

  tags = var.tags
}

resource "aws_security_group" "rds" {
  name   = "${var.db_identifier}-sg"
  vpc_id = var.vpc_id
  tags   = { "Name" = "${var.db_identifier}-sg" }
}

resource "aws_security_group_rule" "allow_from_transit" {
  count = var.transit_cidr == "" ? 0 : 1

  security_group_id = aws_security_group.rds.id
  type              = "ingress"
  from_port         = var.port
  to_port           = var.port
  cidr_blocks       = ["${var.transit_cidr}"]
  protocol          = "tcp"
}

locals {
  security_group_foreach = {
    for index, sg_id in var.additional_sg_ids :
    index => sg_id
  }
}

resource "aws_security_group_rule" "allow_from_additional_cidrs" {
  count = length(var.additional_cidrs) > 0 ? 1 : 0

  security_group_id = aws_security_group.rds.id
  type              = "ingress"
  from_port         = var.port
  to_port           = var.port
  cidr_blocks       = var.additional_cidrs
  protocol          = "tcp"
}

resource "aws_security_group_rule" "allow_from_additional_sgs" {
  for_each = local.security_group_foreach

  security_group_id        = aws_security_group.rds.id
  type                     = "ingress"
  from_port                = var.port
  to_port                  = var.port
  source_security_group_id = each.value
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "out_all" {
  security_group_id = aws_security_group.rds.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
  protocol          = "-1"
}
