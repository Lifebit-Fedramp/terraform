resource "aws_subnet" "firewall" {
  for_each          = { for idx, cidr_block in var.firewall_subnets : cidr_block => idx }
  vpc_id            = aws_vpc.main[0].id
  cidr_block        = each.key
  availability_zone = data.aws_availability_zones.this.names[each.value]

  tags = {
    Name = "${var.name}-FW-AZ${substr(upper(data.aws_availability_zones.this.names[each.value]), -1, 1)}"
  }
}

resource "aws_subnet" "public" {
  for_each          = { for idx, cidr_block in var.public_subnets : cidr_block => idx }
  vpc_id            = aws_vpc.main[0].id
  cidr_block        = each.key
  availability_zone = data.aws_availability_zones.this.names[each.value]

  tags = {
    Name                     = "${var.name}-AWS-PUB-AZ${substr(upper(data.aws_availability_zones.this.names[each.value]), -1, 1)}",
    "kubernetes.io/role/elb" = "1"
  }
}

resource "aws_subnet" "public_dmz" {
  for_each          = { for idx, cidr_block in var.public_dmz_subnets : cidr_block => idx }
  vpc_id            = aws_vpc.main[0].id
  cidr_block        = each.key
  availability_zone = data.aws_availability_zones.this.names[each.value]

  tags = {
    Name                     = "${var.name}-AWS-PUB-DMZ-AZ${substr(upper(data.aws_availability_zones.this.names[each.value]), -1, 1)}",
    "kubernetes.io/role/elb" = "1"
  }
}

resource "aws_subnet" "aws_private" {
  for_each          = { for idx, cidr_block in var.private_subnets : cidr_block => idx }
  vpc_id            = aws_vpc.main[0].id
  cidr_block        = each.key
  availability_zone = data.aws_availability_zones.this.names[each.value]

  tags = {
    Name = "${var.name}-AWS-PRV-AZ${substr(upper(data.aws_availability_zones.this.names[each.value]), -1, 1)}"
  }
}

resource "aws_subnet" "app_private" {
  for_each          = { for idx, cidr_block in var.private_ec2_subnets : cidr_block => idx }
  vpc_id            = aws_vpc.main[0].id
  cidr_block        = each.key
  availability_zone = data.aws_availability_zones.this.names[each.value]

  tags = {
    Name                              = "${var.name}-APP-PRV-EC2-AZ${substr(upper(data.aws_availability_zones.this.names[each.value]), -1, 1)}",
    "kubernetes.io/role/internal-elb" = "1"
  }
}

resource "aws_subnet" "tgw" {
  for_each          = { for idx, cidr_block in var.transit_gateway_subnets : cidr_block => idx }
  vpc_id            = aws_vpc.main[0].id
  cidr_block        = each.key
  availability_zone = data.aws_availability_zones.this.names[each.value]

  tags = {
    Name = "${var.name}-TGW-AZ${substr(upper(data.aws_availability_zones.this.names[each.value]), -1, 1)}"
  }
}
