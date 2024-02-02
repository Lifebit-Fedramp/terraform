resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.main[0].id

  tags = {
    Name = "${var.name}-IGW"
  }
}
