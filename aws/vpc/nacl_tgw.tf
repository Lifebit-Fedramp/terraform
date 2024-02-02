resource "aws_network_acl" "tgw" {
  vpc_id = aws_vpc.main[0].id

  # All Traffic - WORKLOAD VPC
  ingress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = var.cidr_range
    from_port  = 0
    to_port    = 0
  }

  dynamic "ingress" {
    for_each = concat(var.nacl_ingress_rules, var.nacl_tgw_ingress_rules)
    content {
      rule_no    = 101 + ingress.key
      protocol   = ingress.value.protocol
      action     = ingress.value.action
      cidr_block = ingress.value.cidr_block
      from_port  = ingress.value.from_port
      to_port    = ingress.value.to_port
    }
  }

  # All Traffic - WORKLOAD VPC
  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = var.cidr_range
    from_port  = 0
    to_port    = 0
  }


  dynamic "egress" {
    for_each = concat(var.nacl_egress_rules, var.nacl_tgw_egress_rules)
    content {
      rule_no    = 101 + egress.key
      protocol   = egress.value.protocol
      action     = egress.value.action
      cidr_block = egress.value.cidr_block
      from_port  = egress.value.from_port
      to_port    = egress.value.to_port
    }
  }

  tags = {
    Name = "${var.name}-TGW-NACL"
  }
}

resource "aws_network_acl_association" "tgw" {
  for_each = {
    for subnet in aws_subnet.tgw : subnet.id => subnet
    if !var.use_default_nacl_copy
  }
  network_acl_id = aws_network_acl.tgw.id
  subnet_id      = each.key
}
