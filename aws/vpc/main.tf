resource "aws_vpc" "main" {
  count                = var.create_vpn ? 1 : 0
  cidr_block           = var.cidr_range
  enable_dns_hostnames = "true"

  tags = {
    Name = "${var.name}-VPC"
  }
}
