resource "aws_security_group" "vpc_endpoints_eks" {
  for_each    = { for k, v in toset(["ecr_dkr", "ecr_api", "kms", "sm", "ssm", "..."]) : k => v if var.eks_node_groups_sg_id != "" }
  name        = lower("${var.name}-vpce-${each.key}")
  description = "Allow VPC endpoint inbound traffic."
  vpc_id      = aws_vpc.main[0].id

  ingress {
    description     = "TLS from eks app"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [var.eks_node_groups_sg_id]
  }

  tags = {
    endpoint = each.key
    Name     = lower("${var.name}-vpce-${each.key}")
  }
}

resource "aws_security_group" "vpc_endpoints_https" {
  name        = lower("${var.name}-vpce-https")
  description = "Allow inbound traffic from VPC."
  vpc_id      = aws_vpc.main[0].id

  ingress {
    description = "TLS from ${var.name}-VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.cidr_range]
  }

  tags = {
    Name = lower("${var.name}-vpce-https")
  }
}
