resource "aws_nat_gateway" "ngw" {
  for_each      = aws_subnet.public
  subnet_id     = aws_subnet.public[each.key].id
  allocation_id = aws_eip.ngw[each.key].id

  tags = {
    Name = "${var.name}-NAT-GATEWAY"
  }
}

resource "aws_eip" "ngw" {
  for_each = aws_subnet.public
  domain   = "vpc"
}
