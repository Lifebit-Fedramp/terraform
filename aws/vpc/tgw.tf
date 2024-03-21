resource "aws_ec2_transit_gateway_vpc_attachment" "tgw" {
  count              = var.attach_tgw_to_vpc ? 1 : 0
  subnet_ids         = [for subnet in aws_subnet.tgw : subnet.id]
  transit_gateway_id = var.tgw_id
  vpc_id             = aws_vpc.main[0].id


  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false

  tags = {
    Name = "${var.name}-TGW-VPC-Attachment"
  }
}