data "aws_subnet" "mq_subnets" {
  for_each = toset(var.subnet_ids)
  id       = each.value
}
