data "aws_subnet" "mq_subnets" {
  for_each = toset(var.subnet_ids)
  id       = each.value
}

data "aws_subnet" "app_subnets" {
  for_each = toset(var.app_subnet_ids)
  id       = each.value
}