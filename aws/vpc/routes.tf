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

resource "aws_route_table" "public" {
  for_each = toset(distinct([for subnet in aws_subnet.public : subnet.availability_zone]))  
  vpc_id   = aws_vpc.main[0].id

  dynamic "route" {
    for_each = [
      for subnet in aws_subnet.firewall : subnet
      if subnet.availability_zone == each.key && var.enable_firewall
    ]
    content {
      cidr_block      = "0.0.0.0/0"
      vpc_endpoint_id = local.networkfirewall_endpoints[each.key]
    }
  }

  dynamic "route" {
    for_each = [
      for subnet in aws_subnet.firewall : subnet
      if subnet.availability_zone == each.key && var.tgw_id != "" && var.attach_tgw_to_vpc
    ]
    content {
      cidr_block         = var.tgw_cidr
      transit_gateway_id = var.tgw_id
    }
  }

  tags = {
    Name = "${var.name}-AWS-PUB-AZ${substr(upper(each.key), -1, 1)}-RT"
  }
}

resource "aws_route_table_association" "public" {  
  for_each       = merge(aws_subnet.public_dmz, aws_subnet.public)
  route_table_id = aws_route_table.public[each.value.availability_zone].id
  subnet_id      = each.value.id
}

resource "aws_route_table" "aws_private" {
  for_each = toset(distinct([for subnet in aws_subnet.aws_private : subnet.availability_zone]))
  vpc_id   = aws_vpc.main[0].id
  
  dynamic "route" {
    for_each = [
      for subnet in aws_subnet.public : subnet
      if subnet.availability_zone == each.key
    ]
    content {
      cidr_block     = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.ngw[route.value["cidr_block"]].id
    }
  }

  dynamic "route" {
    for_each = [
      for subnet in aws_subnet.public : subnet
      if subnet.availability_zone == each.key && var.tgw_id != "" && var.attach_tgw_to_vpc
    ]
    content {
      cidr_block         = var.tgw_cidr
      transit_gateway_id = var.tgw_id
    }
  }

  tags = {
    Name = "${var.name}-AWS-PRV-AZ${substr(upper(each.key), -1, 1)}-RT"
  }
}

resource "aws_route_table" "aws_tgw" {  
  vpc_id = aws_vpc.main[0].id
  
  dynamic "route" {
    for_each = var.attach_tgw_to_vpc ? [1] : []
    content {
      cidr_block         = var.tgw_cidr
      transit_gateway_id = var.tgw_id
    }
  }

  tags = {
    Name = "${var.name}-AWS-TGW-RT"
  }
}

resource "aws_route_table_association" "aws_private" {
  for_each       = merge(aws_subnet.aws_private, aws_subnet.app_private)
  route_table_id = aws_route_table.aws_private[each.value.availability_zone].id
  subnet_id      = each.value.id
}

resource "aws_route_table_association" "tgw" {
  for_each       = aws_subnet.tgw
  route_table_id = aws_route_table.aws_tgw.id
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
  for_each               = merge(aws_subnet.public, aws_subnet.public_dmz)
  route_table_id         = aws_route_table.aws_igw_ingress.id
  destination_cidr_block = each.value.cidr_block
  vpc_endpoint_id        = local.networkfirewall_endpoints[each.value.availability_zone]
}
