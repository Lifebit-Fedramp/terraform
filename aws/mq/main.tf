resource "aws_mq_broker" "broker" {
  broker_name = var.name

  apply_immediately          = var.mq_broker_apply_immediately
  auto_minor_version_upgrade = var.mq_broker_auto_minor_version_upgrade
  deployment_mode            = var.deployment_mode
  engine_type                = var.engine_type
  engine_version             = var.engine_version
  host_instance_type         = var.instance_type
  subnet_ids                 = var.subnet_ids

  security_groups = [
    aws_security_group.mq.id
  ]

  logs {
    general = var.mq_broker_logs_general
    audit   = var.mq_broker_logs_audit
  }

  maintenance_window_start_time {
    day_of_week = var.mq_broker_maintenance_day_of_week
    time_of_day = var.mq_broker_maintenance_time_of_day
    time_zone   = var.mq_broker_maintenance_time_zone
  }

  user {
    username       = var.broker_user
    password       = random_password.mq.result
    groups         = ["admin"]
    console_access = true
  }

  tags = var.mq_broker_tags
}

resource "aws_security_group" "mq" {
  name   = "${var.name}-sg"
  vpc_id = var.vpc_id
  tags   = { "Name" = "${var.name}-sg" }

  ingress {
    from_port   = 5671
    to_port     = 5671
    protocol    = "tcp"
    cidr_blocks = values(data.aws_subnet.mq_subnets).*.cidr_block
  }

  ingress {
    from_port   = 15671
    to_port     = 15671
    protocol    = "tcp"
    cidr_blocks = values(data.aws_subnet.mq_subnets).*.cidr_block
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = values(data.aws_subnet.mq_subnets).*.cidr_block
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
