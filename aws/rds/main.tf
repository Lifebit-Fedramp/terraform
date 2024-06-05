data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

resource "aws_db_subnet_group" "db" {
  subnet_ids = var.subnet_ids
}

module "db_instance" {
  source  = "terraform-aws-modules/rds/aws"
  version = "6.6.0"

  identifier                     = var.identifier
  instance_use_identifier_prefix = var.instance_use_identifier_prefix
  custom_iam_instance_profile    = var.custom_iam_instance_profile

  engine                      = var.engine
  engine_version              = var.engine_version
  family                      = var.family
  major_engine_version        = var.major_engine_version
  instance_class              = var.instance_class
  db_name                     = var.db_name
  allow_major_version_upgrade = var.allow_major_version_upgrade
  auto_minor_version_upgrade  = var.auto_minor_version_upgrade

  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_type          = var.storage_type
  storage_throughput    = var.storage_throughput
  iops                  = var.iops

  storage_encrypted = true
  kms_key_id        = aws_kms_key.rds_kms_cmk.arn

  username = var.username
  password = random_password.db_master_pass.result
  port     = var.port

  multi_az               = var.multi_az
  publicly_accessible    = var.publicly_accessible
  subnet_ids             = var.subnet_ids
  create_db_subnet_group = false
  db_subnet_group_name   = aws_db_subnet_group.db.name
  vpc_security_group_ids = [aws_security_group.rds.id]

  maintenance_window               = var.maintenance_window
  apply_immediately                = var.apply_immediately
  copy_tags_to_snapshot            = true
  backup_window                    = var.backup_window
  backup_retention_period          = var.backup_retention_period
  skip_final_snapshot              = false
  final_snapshot_identifier_prefix = var.final_snapshot_identifier_prefix
  snapshot_identifier              = var.snapshot_identifier
  deletion_protection              = true

  create_cloudwatch_log_group            = true
  cloudwatch_log_group_kms_key_id        = aws_kms_key.rds_kms_cmk.arn
  enabled_cloudwatch_logs_exports        = var.enabled_cloudwatch_logs_exports
  cloudwatch_log_group_retention_in_days = var.cloudwatch_log_group_retention_in_days

  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_kms_key_id       = aws_kms_key.rds_kms_cmk.arn
  performance_insights_retention_period = var.performance_insights_retention_period
  create_monitoring_role                = true
  monitoring_role_name                  = "rds-${var.identifier}-monitoring-role"
  monitoring_role_use_name_prefix       = var.monitoring_role_use_name_prefix
  monitoring_role_description           = var.monitoring_role_description
  monitoring_role_permissions_boundary  = var.monitoring_role_permissions_boundary
  monitoring_interval                   = var.monitoring_interval

  create_db_parameter_group       = true
  parameter_group_name            = var.parameter_group_name
  parameter_group_use_name_prefix = var.parameter_group_use_name_prefix
  parameter_group_description     = var.parameter_group_description
  parameters                      = var.parameters

  create_db_option_group       = var.create_db_option_group
  option_group_name            = var.option_group_name
  option_group_use_name_prefix = var.option_group_use_name_prefix
  option_group_description     = var.option_group_description
  options                      = var.options

  create_db_instance       = var.create_db_instance
  timezone                 = var.timezone
  timeouts                 = var.timeouts
  option_group_timeouts    = var.option_group_timeouts
  delete_automated_backups = var.delete_automated_backups

  tags = var.tags
}

resource "aws_security_group" "rds" {
  name   = "${var.identifier}-sg"
  vpc_id = var.vpc_id
  tags   = { "Name" = "${var.identifier}-sg" }
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
