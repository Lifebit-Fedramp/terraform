output "vpc_id" {
  value = aws_vpc.main[0].id
}

output "private_ec2_subnet_cidrs" {
  value = var.private_ec2_subnets
}

output "private_data_subnet_ids" {
  value = [for subnet in aws_subnet.app_private : subnet.id]
}

output "private_ec2_aws_subnet_ids" {
  value = [for subnet in aws_subnet.aws_private : subnet.id]
}

output "public_aws_subnet_ids" {
  value = [for subnet in aws_subnet.public : subnet.id]
}

output "public_dmz_subnet_ids" {
  value = [for subnet in aws_subnet.public_dmz : subnet.id]
}

output "default_security_group_id" {
  value = aws_vpc.main[0].default_security_group_id
}

output "vpn_cidr" {
  value = var.vpn_cidr
}

output "vpc_cidr" {
  value = var.cidr_range
}

output "tgw_cidr" {
  value = var.tgw_cidr
}
