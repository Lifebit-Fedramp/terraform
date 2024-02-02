resource "aws_mq_broker" "broker" {
  broker_name = var.name

  engine_type        = var.engine_type
  engine_version     = var.engine_version
  host_instance_type = var.instance_type
  subnet_ids         = var.subnet_ids
  deployment_mode    = "CLUSTER_MULTI_AZ"
  security_groups = [
    aws_security_group.mq.id
  ]

  user {
    username = var.broker_user
    password = random_password.mq.result
  }
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
    from_port   = 5672
    to_port     = 5672
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
