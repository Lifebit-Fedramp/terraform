# terraform-aws-vpc
Terraform aws vpc module for commercial and govcloud accounts.

Configurable endpoint creation for:
* S3
* Secrets Manager
* CloudFormation
* Image Builder
* Logs
* ECR

Other options include:
* Firewall
* TGW Attachment
* FIPS
* Private DNS Endpoints
* VPN

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.network_firewall_flow_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_group.vpc_flow_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_default_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/default_security_group) | resource |
| [aws_ec2_transit_gateway_vpc_attachment.tgw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_vpc_attachment) | resource |
| [aws_eip.ngw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_flow_log.bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/flow_log) | resource |
| [aws_flow_log.cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/flow_log) | resource |
| [aws_iam_role.vpc_flow_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.vpc_flow_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_internet_gateway.gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_kms_key.firewall_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_key.flow_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_key.vpc_flow_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_nat_gateway.ngw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_network_acl.firewall](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl) | resource |
| [aws_network_acl.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl) | resource |
| [aws_network_acl.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl) | resource |
| [aws_network_acl.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl) | resource |
| [aws_network_acl.tgw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl) | resource |
| [aws_network_acl_association.app_private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_association) | resource |
| [aws_network_acl_association.aws_private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_association) | resource |
| [aws_network_acl_association.firewall](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_association) | resource |
| [aws_network_acl_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_association) | resource |
| [aws_network_acl_association.tgw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_association) | resource |
| [aws_networkfirewall_firewall.firewall](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/networkfirewall_firewall) | resource |
| [aws_networkfirewall_firewall_policy.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/networkfirewall_firewall_policy) | resource |
| [aws_networkfirewall_logging_configuration.firewall](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/networkfirewall_logging_configuration) | resource |
| [aws_networkfirewall_rule_group.aws_logging_rulelist](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/networkfirewall_rule_group) | resource |
| [aws_networkfirewall_rule_group.http_rulelist](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/networkfirewall_rule_group) | resource |
| [aws_route.aws_igw_pub_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.aws_igw_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.aws_private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.aws_tgw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.firewall](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.aws_igw_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.aws_private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.firewall](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.tgw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.vpc_endpoints_eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.vpc_endpoints_https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.app_private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.aws_private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.firewall](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public_dmz](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.tgw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_vpc_endpoint.cloudformation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.ec2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.ec2messages](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.ecr_api](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.ecr_dkr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.imagebuilder](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.kms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.secrets_manager](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.ssm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_arn.logs_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/arn) | data source |
| [aws_availability_zones.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.kms_vpc_flow_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_attach_tgw_to_vpc"></a> [attach\_tgw\_to\_vpc](#input\_attach\_tgw\_to\_vpc) | Attach the transit gateway to the VPC | `bool` | `false` | no |
| <a name="input_cidr_range"></a> [cidr\_range](#input\_cidr\_range) | n/a | `any` | n/a | yes |
| <a name="input_create_vpn"></a> [create\_vpn](#input\_create\_vpn) | Turns VPC creatin on and off for accounts | `bool` | `true` | no |
| <a name="input_eks_node_groups_sg_id"></a> [eks\_node\_groups\_sg\_id](#input\_eks\_node\_groups\_sg\_id) | Security group id of the eks node group. | `string` | `""` | no |
| <a name="input_enable_cloudformation_endpoint"></a> [enable\_cloudformation\_endpoint](#input\_enable\_cloudformation\_endpoint) | n/a | `bool` | `false` | no |
| <a name="input_enable_ecr_endpoints"></a> [enable\_ecr\_endpoints](#input\_enable\_ecr\_endpoints) | n/a | `bool` | `false` | no |
| <a name="input_enable_firewall"></a> [enable\_firewall](#input\_enable\_firewall) | n/a | `bool` | `false` | no |
| <a name="input_enable_imagebuilder_endpoint"></a> [enable\_imagebuilder\_endpoint](#input\_enable\_imagebuilder\_endpoint) | n/a | `bool` | `false` | no |
| <a name="input_enable_logs_endpoint"></a> [enable\_logs\_endpoint](#input\_enable\_logs\_endpoint) | n/a | `bool` | `false` | no |
| <a name="input_enable_s3_endpoint"></a> [enable\_s3\_endpoint](#input\_enable\_s3\_endpoint) | n/a | `bool` | `false` | no |
| <a name="input_enable_sm_endpoint"></a> [enable\_sm\_endpoint](#input\_enable\_sm\_endpoint) | n/a | `bool` | `false` | no |
| <a name="input_endpoint_private_dns_endpoints_enabled"></a> [endpoint\_private\_dns\_endpoints\_enabled](#input\_endpoint\_private\_dns\_endpoints\_enabled) | Toggles private dns endpoints for VPC endpoints | `bool` | `true` | no |
| <a name="input_fips_enabled"></a> [fips\_enabled](#input\_fips\_enabled) | Whether or not fips endpoints are enabled | `bool` | `true` | no |
| <a name="input_firewall_subnets"></a> [firewall\_subnets](#input\_firewall\_subnets) | n/a | `list` | `[]` | no |
| <a name="input_flow_logs_bucket"></a> [flow\_logs\_bucket](#input\_flow\_logs\_bucket) | Bucket arn for flow logs | `string` | n/a | yes |
| <a name="input_http_firewall_egress_allowlist"></a> [http\_firewall\_egress\_allowlist](#input\_http\_firewall\_egress\_allowlist) | domains allowed to egress out of the vpc | `list` | <pre>[<br>  "google.com"<br>]</pre> | no |
| <a name="input_nacl_egress_rules"></a> [nacl\_egress\_rules](#input\_nacl\_egress\_rules) | Additional NACL egress rules for all subnets. Prepended to more specific rules. | <pre>list(object({<br>    protocol   = string<br>    action     = string<br>    cidr_block = string<br>    from_port  = number<br>    to_port    = number<br>  }))</pre> | `[]` | no |
| <a name="input_nacl_fw_egress_rules"></a> [nacl\_fw\_egress\_rules](#input\_nacl\_fw\_egress\_rules) | Additional NACL egress rules for FW subnets | <pre>list(object({<br>    protocol   = string<br>    action     = string<br>    cidr_block = string<br>    from_port  = number<br>    to_port    = number<br>  }))</pre> | `[]` | no |
| <a name="input_nacl_fw_ingress_rules"></a> [nacl\_fw\_ingress\_rules](#input\_nacl\_fw\_ingress\_rules) | Additional NACL ingress rules for FW subnets | <pre>list(object({<br>    protocol   = string<br>    action     = string<br>    cidr_block = string<br>    from_port  = number<br>    to_port    = number<br>  }))</pre> | `[]` | no |
| <a name="input_nacl_ingress_rules"></a> [nacl\_ingress\_rules](#input\_nacl\_ingress\_rules) | Additional NACL ingress rules for all subnets. Prepended to more specific rules. | <pre>list(object({<br>    protocol   = string<br>    action     = string<br>    cidr_block = string<br>    from_port  = number<br>    to_port    = number<br>  }))</pre> | `[]` | no |
| <a name="input_nacl_private_egress_rules"></a> [nacl\_private\_egress\_rules](#input\_nacl\_private\_egress\_rules) | Additional NACL egress rules for PRV subnets | <pre>list(object({<br>    protocol   = string<br>    action     = string<br>    cidr_block = string<br>    from_port  = number<br>    to_port    = number<br>  }))</pre> | `[]` | no |
| <a name="input_nacl_private_ingress_rules"></a> [nacl\_private\_ingress\_rules](#input\_nacl\_private\_ingress\_rules) | Additional NACL ingress rules for PRV subnets | <pre>list(object({<br>    protocol   = string<br>    action     = string<br>    cidr_block = string<br>    from_port  = number<br>    to_port    = number<br>  }))</pre> | `[]` | no |
| <a name="input_nacl_public_egress_rules"></a> [nacl\_public\_egress\_rules](#input\_nacl\_public\_egress\_rules) | Additional NACL egress rules for PUB subnets | <pre>list(object({<br>    protocol   = string<br>    action     = string<br>    cidr_block = string<br>    from_port  = number<br>    to_port    = number<br>  }))</pre> | `[]` | no |
| <a name="input_nacl_public_ingress_rules"></a> [nacl\_public\_ingress\_rules](#input\_nacl\_public\_ingress\_rules) | Additional NACL ingress rules for PUB subnets | <pre>list(object({<br>    protocol   = string<br>    action     = string<br>    cidr_block = string<br>    from_port  = number<br>    to_port    = number<br>  }))</pre> | `[]` | no |
| <a name="input_nacl_tgw_egress_rules"></a> [nacl\_tgw\_egress\_rules](#input\_nacl\_tgw\_egress\_rules) | Additional NACL egress rules for TGW subnets | <pre>list(object({<br>    protocol   = string<br>    action     = string<br>    cidr_block = string<br>    from_port  = number<br>    to_port    = number<br>  }))</pre> | `[]` | no |
| <a name="input_nacl_tgw_ingress_rules"></a> [nacl\_tgw\_ingress\_rules](#input\_nacl\_tgw\_ingress\_rules) | Additional NACL ingress rules for TGW subnets | <pre>list(object({<br>    protocol   = string<br>    action     = string<br>    cidr_block = string<br>    from_port  = number<br>    to_port    = number<br>  }))</pre> | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | Name for this VPC and subsequent resources | `string` | n/a | yes |
| <a name="input_private_ec2_subnets"></a> [private\_ec2\_subnets](#input\_private\_ec2\_subnets) | n/a | `list` | `[]` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | n/a | `any` | n/a | yes |
| <a name="input_public_dmz_subnets"></a> [public\_dmz\_subnets](#input\_public\_dmz\_subnets) | n/a | `list` | `[]` | no |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | n/a | `any` | n/a | yes |
| <a name="input_rules_source_list"></a> [rules\_source\_list](#input\_rules\_source\_list) | domains allowed to egress out of the vpc | <pre>list(object({<br>    # Majority of the items in this object are unused by terraform<br>    # but we need them for auditing purposes. Please dont remove without approval.<br>    destination   = string<br>    owned_by      = string<br>    approved_by   = string<br>    approved_date = string<br>    description   = string<br>  }))</pre> | `[]` | no |
| <a name="input_tgw_cidr"></a> [tgw\_cidr](#input\_tgw\_cidr) | n/a | `string` | `""` | no |
| <a name="input_tgw_id"></a> [tgw\_id](#input\_tgw\_id) | n/a | `string` | `""` | no |
| <a name="input_tls_firewall_egress_allowlist"></a> [tls\_firewall\_egress\_allowlist](#input\_tls\_firewall\_egress\_allowlist) | domains allowed to egress out of the vpc | <pre>map(list(object({<br>    # Majority of the items in this object are unused by terraform, but are required for auditing.<br>    destination   = string<br>    owned_by      = string<br>    approved_by   = string<br>    approved_date = string<br>    description   = string<br>  })))</pre> | `{}` | no |
| <a name="input_transit_gateway_subnets"></a> [transit\_gateway\_subnets](#input\_transit\_gateway\_subnets) | n/a | `list` | `[]` | no |
| <a name="input_use_default_nacl_copy"></a> [use\_default\_nacl\_copy](#input\_use\_default\_nacl\_copy) | Turns off custom NACLs for testing | `bool` | `true` | no |
| <a name="input_vpn_cidr"></a> [vpn\_cidr](#input\_vpn\_cidr) | n/a | `string` | `"10.0.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_default_security_group_id"></a> [default\_security\_group\_id](#output\_default\_security\_group\_id) | n/a |
| <a name="output_nat_gateway_public_ips"></a> [nat\_gateway\_public\_ips](#output\_nat\_gateway\_public\_ips) | n/a |
| <a name="output_private_data_subnet_ids"></a> [private\_data\_subnet\_ids](#output\_private\_data\_subnet\_ids) | n/a |
| <a name="output_private_ec2_app_subnet_ids"></a> [private\_ec2\_app\_subnet\_ids](#output\_private\_ec2\_app\_subnet\_ids) | n/a |
| <a name="output_private_ec2_subnet_cidrs"></a> [private\_ec2\_subnet\_cidrs](#output\_private\_ec2\_subnet\_cidrs) | n/a |
| <a name="output_public_aws_subnet_ids"></a> [public\_aws\_subnet\_ids](#output\_public\_aws\_subnet\_ids) | n/a |
| <a name="output_public_dmz_subnet_ids"></a> [public\_dmz\_subnet\_ids](#output\_public\_dmz\_subnet\_ids) | n/a |
| <a name="output_tgw_cidr"></a> [tgw\_cidr](#output\_tgw\_cidr) | n/a |
| <a name="output_vpc_cidr"></a> [vpc\_cidr](#output\_vpc\_cidr) | n/a |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | n/a |
| <a name="output_vpn_cidr"></a> [vpn\_cidr](#output\_vpn\_cidr) | n/a |
<!-- END_TF_DOCS -->