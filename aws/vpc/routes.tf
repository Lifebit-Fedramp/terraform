resource "aws_route_table" "firewall" {
  vpc_id = aws_vpc.main[0].id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }

  tags = {
    Name = "${var.name}-FW-RT"
  }
}

resource "aws_route_table_association" "firewall" {
  for_each       = aws_subnet.firewall
  route_table_id = aws_route_table.firewall.id
  subnet_id      = aws_subnet.firewall[each.key].id
}

/**resource "aws_route_table" "public" {
  for_each = aws_subnet.public
  vpc_id   = aws_vpc.main[0].id

  dynamic "route" {
    for_each = [
      for subnet in aws_subnet.firewall : subnet
      if subnet.availability_zone == aws_subnet.public[each.key].availability_zone && var.enable_firewall
    ]
    content {
      cidr_block      = "0.0.0.0/0"
      vpc_endpoint_id = local.networkfirewall_endpoints[aws_subnet.public[each.key].availability_zone]
    }
  }

  dynamic "route" {
    for_each = [
      for subnet in aws_subnet.firewall : subnet
      if subnet.availability_zone == aws_subnet.public[each.key].availability_zone && var.tgw_id != "" && var.attach_tgw_to_vpc
    ]
    content {
      cidr_block         = var.tgw_cidr
      transit_gateway_id = var.tgw_id
    }
  }

  tags = {
    Name = "${var.name}-AWS-PUB-AZ${substr(upper(aws_subnet.public[each.key].availability_zone), -1, 1)}-RT"
  }
}

resource "aws_route_table_association" "public" {
  for_each       = aws_subnet.public
  route_table_id = aws_route_table.public[each.key].id
  subnet_id      = aws_subnet.public[each.key].id
}

resource "aws_route_table" "aws_private" {
  for_each = aws_subnet.aws_private
  vpc_id   = aws_vpc.main[0].id

  dynamic "route" {
    for_each = [
      for subnet in aws_subnet.public : subnet
      if subnet.availability_zone == aws_subnet.aws_private[each.key].availability_zone
    ]
    content {
      cidr_block     = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.ngw[route.value["cidr_block"]].id
    }
  }

  dynamic "route" {
    for_each = [
      for subnet in aws_subnet.public : subnet
      if subnet.availability_zone == aws_subnet.aws_private[each.key].availability_zone && var.tgw_id != "" && var.attach_tgw_to_vpc
    ]
    content {
      cidr_block         = var.tgw_cidr
      transit_gateway_id = var.tgw_id
    }
  }

  tags = {
    Name = "${var.name}-AWS-PRV-AZ${substr(upper(aws_subnet.aws_private[each.key].availability_zone), -1, 1)}-RT"
  }
}


resource "aws_route_table" "app_private" {
  for_each = aws_subnet.app_private
  vpc_id   = aws_vpc.main[0].id

  dynamic "route" {
    for_each = [
      for subnet in aws_subnet.public : subnet
      if subnet.availability_zone == aws_subnet.app_private[each.key].availability_zone
    ]
    content {
      cidr_block     = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.ngw[route.value["cidr_block"]].id
    }
  }

  dynamic "route" {
    for_each = [
      for subnet in aws_subnet.public : subnet
      if subnet.availability_zone == aws_subnet.app_private[each.key].availability_zone && var.tgw_id != "" && var.attach_tgw_to_vpc
    ]
    content {
      cidr_block         = var.tgw_cidr
      transit_gateway_id = var.tgw_id
    }
  }

  tags = {
    Name = "${var.name}-AWS-PRV-AZ${substr(upper(aws_subnet.app_private[each.key].availability_zone), -1, 1)}-RT"
  }
}

resource "aws_route_table" "aws_tgw" {
  for_each = aws_subnet.tgw
  vpc_id   = aws_vpc.main[0].id

  dynamic "route" {
    for_each = [
      for subnet in aws_subnet.public : subnet
      if subnet.availability_zone == aws_subnet.tgw[each.key].availability_zone
    ]
    content {
      cidr_block     = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.ngw[route.value["cidr_block"]].id
    }
  }

  dynamic "route" {
    for_each = [
      for subnet in aws_subnet.public : subnet
      if subnet.availability_zone == aws_subnet.tgw[each.key].availability_zone && var.tgw_id != "" && var.attach_tgw_to_vpc
    ]
    content {
      cidr_block         = var.tgw_cidr
      transit_gateway_id = var.tgw_id
    }
  }

  tags = {
    Name = "${var.name}-AWS-TGW-AZ${substr(upper(aws_subnet.tgw[each.key].availability_zone), -1, 1)}-RT"
  }
}

resource "aws_route_table_association" "aws_private" {
  for_each       = aws_subnet.aws_private
  route_table_id = aws_route_table.aws_private[each.key].id
  subnet_id      = aws_subnet.aws_private[each.key].id
}

resource "aws_route_table_association" "app_private" {
  for_each       = aws_subnet.app_private
  route_table_id = aws_route_table.app_private[each.key].id
  subnet_id      = aws_subnet.app_private[each.key].id
}

resource "aws_route_table_association" "tgw" {
  for_each       = aws_subnet.tgw
  route_table_id = aws_route_table.aws_tgw[each.key].id
  subnet_id      = aws_subnet.tgw[each.key].id
}

resource "aws_route_table" "aws_igw_ingress" {
  vpc_id = aws_vpc.main[0].id

  tags = {
    "Name" = "${var.name}-IGW-INGRESS-RT"
  }
}

resource "aws_route_table_association" "aws_igw_ingress" {
  route_table_id = aws_route_table.aws_igw_ingress.id
  gateway_id     = aws_internet_gateway.gateway.id
  depends_on = [
    aws_route_table.aws_igw_ingress,
    aws_internet_gateway.gateway
  ]
}

resource "aws_route" "aws_igw_pub_route" {
  count                  = length(aws_subnet.firewall)
  route_table_id         = aws_route_table.aws_igw_ingress.id
  destination_cidr_block = local.protected_pub_cidr_blocks[data.aws_availability_zones.this.names[count.index]]
  vpc_endpoint_id        = local.networkfirewall_endpoints[data.aws_availability_zones.this.names[count.index]]
}
**/