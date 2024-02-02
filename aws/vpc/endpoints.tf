resource "aws_vpc_endpoint" "s3" {
  vpc_id       = aws_vpc.main[0].id
  service_name = "com.amazonaws.${data.aws_region.current.name}.s3"

  tags = {
    Name = "${var.name}-s3${var.fips_enabled == true ? "-fips" : ""}-endpoint"
  }
}

resource "aws_vpc_endpoint" "kms" {
  vpc_id            = aws_vpc.main[0].id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.kms${var.fips_enabled == true ? "-fips" : ""}"
  vpc_endpoint_type = "Interface"

  private_dns_enabled = var.endpoint_private_dns_endpoints_enabled

  security_group_ids = var.eks_node_groups_sg_id != "" ? [
    aws_security_group.vpc_endpoints_eks["kms"].id,
    aws_security_group.vpc_endpoints_https.id
  ] : [aws_security_group.vpc_endpoints_https.id]

  subnet_ids = var.name == "<account_name>" ? [for subnet in aws_subnet.tgw : subnet.id] : [for subnet in aws_subnet.aws_private : subnet.id]

  tags = {
    Name = "${var.name}-kms${var.fips_enabled == true ? "-fips" : ""}-endpoint"
  }
}

resource "aws_vpc_endpoint" "secretsmanager" {
  vpc_id            = aws_vpc.main[0].id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.secretsmanager"
  vpc_endpoint_type = "Interface"

  private_dns_enabled = var.endpoint_private_dns_endpoints_enabled

  security_group_ids = var.eks_node_groups_sg_id != "" ? [
    aws_security_group.vpc_endpoints_eks["sm"].id,
    aws_security_group.vpc_endpoints_https.id
  ] : [aws_security_group.vpc_endpoints_https.id]

  subnet_ids = var.name == "<account_name>" ? [for subnet in aws_subnet.tgw : subnet.id] : [for subnet in aws_subnet.aws_private : subnet.id]

  tags = {
    Name = "${var.name}-secretsmanager${var.fips_enabled == true ? "-fips" : ""}-endpoint"
  }
}

resource "aws_vpc_endpoint" "ssm" {
  vpc_id            = aws_vpc.main[0].id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.ssm"
  vpc_endpoint_type = "Interface"

  private_dns_enabled = var.endpoint_private_dns_endpoints_enabled

  security_group_ids = var.eks_node_groups_sg_id != "" ? [
    aws_security_group.vpc_endpoints_eks["ssm"].id,
    aws_security_group.vpc_endpoints_https.id
  ] : [aws_security_group.vpc_endpoints_https.id]

  subnet_ids = var.name == "<account_name>" ? [for subnet in aws_subnet.tgw : subnet.id] : [for subnet in aws_subnet.aws_private : subnet.id]

  tags = {
    Name = "${var.name}-ssm${var.fips_enabled == true ? "-fips" : ""}-endpoint"
  }
}

resource "aws_vpc_endpoint" "imagebuilder" {
  vpc_id            = aws_vpc.main[0].id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.imagebuilder"
  vpc_endpoint_type = "Interface"

  private_dns_enabled = var.endpoint_private_dns_endpoints_enabled

  security_group_ids = var.eks_node_groups_sg_id != "" ? [
    aws_security_group.vpc_endpoints_eks["imagebuilder"].id,
    aws_security_group.vpc_endpoints_https.id
  ] : [aws_security_group.vpc_endpoints_https.id]

  subnet_ids = var.name == "<account_name>" ? [for subnet in aws_subnet.tgw : subnet.id] : [for subnet in aws_subnet.aws_private : subnet.id]

  tags = {
    Name = "${var.name}-imagebuilder${var.fips_enabled == true ? "-fips" : ""}-endpoint"
  }
}

resource "aws_vpc_endpoint" "cloudformation" {
  vpc_id            = aws_vpc.main[0].id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.cloudformation"
  vpc_endpoint_type = "Interface"

  private_dns_enabled = var.endpoint_private_dns_endpoints_enabled

  security_group_ids = var.eks_node_groups_sg_id != "" ? [
    aws_security_group.vpc_endpoints_eks["cloudformation"].id,
    aws_security_group.vpc_endpoints_https.id
  ] : [aws_security_group.vpc_endpoints_https.id]

  subnet_ids = var.name == "<account_name>" ? [for subnet in aws_subnet.tgw : subnet.id] : [for subnet in aws_subnet.aws_private : subnet.id]

  tags = {
    Name = "${var.name}-cloudformation${var.fips_enabled == true ? "-fips" : ""}-endpoint"
  }
}

resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id            = aws_vpc.main[0].id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.ecr.dkr"
  vpc_endpoint_type = "Interface"

  private_dns_enabled = var.endpoint_private_dns_endpoints_enabled

  security_group_ids = var.eks_node_groups_sg_id != "" ? [
    aws_security_group.vpc_endpoints_eks["ecr_dkr"].id,
    aws_security_group.vpc_endpoints_https.id
  ] : [aws_security_group.vpc_endpoints_https.id]

  subnet_ids = var.name == "<account_name>" ? [for subnet in aws_subnet.tgw : subnet.id] : [for subnet in aws_subnet.aws_private : subnet.id]

  tags = {
    Name = "${var.name}-ecr-endpoint-dkr"
  }
}

resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id            = aws_vpc.main[0].id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.ecr.api"
  vpc_endpoint_type = "Interface"

  private_dns_enabled = var.endpoint_private_dns_endpoints_enabled

  security_group_ids = var.eks_node_groups_sg_id != "" ? [
    aws_security_group.vpc_endpoints_eks["ecr_api"].id,
    aws_security_group.vpc_endpoints_https.id
  ] : [aws_security_group.vpc_endpoints_https.id]

  subnet_ids = var.name == "<account_name>" ? [for subnet in aws_subnet.tgw : subnet.id] : [for subnet in aws_subnet.aws_private : subnet.id]

  tags = {
    Name = "${var.name}-ecr-endpoint-api"
  }
}

resource "aws_vpc_endpoint" "ec2" {
  vpc_id            = aws_vpc.main[0].id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.ec2"
  vpc_endpoint_type = "Interface"

  private_dns_enabled = var.endpoint_private_dns_endpoints_enabled

  security_group_ids = var.eks_node_groups_sg_id != "" ? [
    aws_security_group.vpc_endpoints_eks["ec2"].id,
    aws_security_group.vpc_endpoints_https.id
  ] : [aws_security_group.vpc_endpoints_https.id]

  subnet_ids = var.name == "<account_name>" ? [for subnet in aws_subnet.tgw : subnet.id] : [for subnet in aws_subnet.aws_private : subnet.id]

  tags = {
    Name = "${var.name}-ec2-endpoint"
  }
}


resource "aws_vpc_endpoint" "ec2messages" {
  vpc_id            = aws_vpc.main[0].id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.ec2messages"
  vpc_endpoint_type = "Interface"

  private_dns_enabled = var.endpoint_private_dns_endpoints_enabled

  security_group_ids = var.eks_node_groups_sg_id != "" ? [
    aws_security_group.vpc_endpoints_eks["ec2messages"].id,
    aws_security_group.vpc_endpoints_https.id
  ] : [aws_security_group.vpc_endpoints_https.id]

  subnet_ids = var.name == "<account_name>" ? [for subnet in aws_subnet.tgw : subnet.id] : [for subnet in aws_subnet.aws_private : subnet.id]

  tags = {
    Name = "${var.name}-ec2messages-endpoint"
  }
}
