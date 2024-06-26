resource "aws_ec2_transit_gateway" "tgw" {
  description                    = var.name
  auto_accept_shared_attachments = "disable"

  default_route_table_association = "disable"
  default_route_table_propagation = "disable"

  tags = {
    Name = var.name
  }
}

resource "aws_ram_resource_share" "share_tgw" {
  name                      = "${var.name}-share"
  allow_external_principals = true
}

resource "aws_ram_resource_association" "tgw_share" {
  resource_arn       = aws_ec2_transit_gateway.tgw.arn
  resource_share_arn = aws_ram_resource_share.share_tgw.id
}

resource "aws_ram_principal_association" "tgw_share" {
  principal          = var.aws_orgs_arn
  resource_share_arn = aws_ram_resource_share.share_tgw.id
}

resource "aws_ec2_transit_gateway_vpc_attachment_accepter" "tgw" {
  for_each                      = local.tgw_accepter_ids
  transit_gateway_attachment_id = each.value

  tags = {
    Name = "${each.key}-TGW-VPC-Attachment-Accepter"
  }
}

resource "aws_ec2_transit_gateway_route_table" "attachment_rt" {
  for_each           = var.vpc_attachment_id_map
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  tags = {
    Name = "${each.key}-Route-Table"
  }
}

resource "aws_ec2_transit_gateway_route_table_association" "rt_association" {
  for_each                       = var.vpc_attachment_id_map
  transit_gateway_attachment_id  = each.value
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.attachment_rt[each.key].id
}

# resource "aws_ec2_transit_gateway_route_table_propagation" "vpc_routing_domain" {
#   for_each = {
#     for attachment in local.tgw_attachments : attachment => attachment
#     if var.create_tgw_rt
#   }

#   transit_gateway_attachment_id  = each.value
#   transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.vpc_routing_domain.id
# }
