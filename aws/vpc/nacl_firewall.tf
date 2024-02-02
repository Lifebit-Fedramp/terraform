resource "aws_network_acl" "firewall" {
  count  = var.enable_firewall == true ? 1 : 0
  vpc_id = aws_vpc.main[0].id

  ingress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = var.cidr_range
    from_port  = 0
    to_port    = 0
  }

  dynamic "ingress" {
    for_each = concat(var.nacl_ingress_rules, var.nacl_fw_ingress_rules)
    content {
      rule_no    = 101 + ingress.key
      protocol   = ingress.value.protocol
      action     = ingress.value.action
      cidr_block = ingress.value.cidr_block
      from_port  = ingress.value.from_port
      to_port    = ingress.value.to_port
    }
  }

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = var.cidr_range
    from_port  = 0
    to_port    = 0
  }

  dynamic "egress" {
    for_each = concat(var.nacl_egress_rules, var.nacl_fw_egress_rules)
    content {
      rule_no    = 101 + egress.key
      protocol   = egress.value.protocol
      action     = egress.value.action
      cidr_block = egress.value.cidr_block
      from_port  = egress.value.from_port
      to_port    = egress.value.to_port
    }
  }

  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  tags = {
    Name = "${var.name}-FW-NACL"
  }

}

resource "aws_network_acl_association" "firewall" {
  for_each = {
    for subnet in aws_subnet.firewall : subnet.id => subnet
    if !var.use_default_nacl_copy && var.enable_firewall
  }
  network_acl_id = aws_network_acl.firewall[0].id
  subnet_id      = each.key
}
