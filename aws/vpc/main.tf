resource "aws_vpc" "main" {
  count                = var.create_vpn ? 1 : 0
  cidr_block           = var.cidr_range
  enable_dns_hostnames = "true"

  tags = {
    Name = "${var.name}-VPC"
  }
}

resource "aws_default_security_group" "default" {
  count  = var.create_vpn ? 1 : 0
  vpc_id = aws_vpc.main[0].id

  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}