locals {
  networkfirewall_endpoints = try({
    for i in aws_networkfirewall_firewall.firewall[0].firewall_status[0].sync_states : i.availability_zone => i.attachment[0].endpoint_id
    if var.enable_firewall
  }, {})
  protected_pub_cidr_blocks = { for i in merge(aws_subnet.public_dmz, aws_subnet.public) : i.availability_zone => i.cidr_block }
}
