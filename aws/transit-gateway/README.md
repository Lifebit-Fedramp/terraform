# terraform-aws-transit-gateway
Terraform aws transit gateway module for commercial and govcloud accounts.

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
| [aws_cloudwatch_log_group.tgw_flow_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_ec2_transit_gateway.tgw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway) | resource |
| [aws_ec2_transit_gateway_route_table.attachment_rt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table) | resource |
| [aws_ec2_transit_gateway_route_table_association.rt_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route_table_association) | resource |
| [aws_ec2_transit_gateway_vpc_attachment_accepter.tgw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_vpc_attachment_accepter) | resource |
| [aws_flow_log.bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/flow_log) | resource |
| [aws_flow_log.tgw_cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/flow_log) | resource |
| [aws_iam_role.tgw_flow_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.tgw_flow_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_kms_key.tgw_flow_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_ram_principal_association.tgw_share](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_principal_association) | resource |
| [aws_ram_resource_association.tgw_share](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_association) | resource |
| [aws_ram_resource_share.share_tgw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_share) | resource |
| [aws_arn.logs_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/arn) | data source |
| [aws_availability_zones.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.kms_tgw_flow_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_accept_tgw_attachment"></a> [accept\_tgw\_attachment](#input\_accept\_tgw\_attachment) | True false value to accept transit gateway attachments | `bool` | `false` | no |
| <a name="input_accounts_to_share"></a> [accounts\_to\_share](#input\_accounts\_to\_share) | aws account ids to share the tgw with | `list(string)` | `[]` | no |
| <a name="input_aws_orgs_arn"></a> [aws\_orgs\_arn](#input\_aws\_orgs\_arn) | The AWS Orgs ARN principal to associate with the resource share. | `string` | n/a | yes |
| <a name="input_create_tgw_rt"></a> [create\_tgw\_rt](#input\_create\_tgw\_rt) | Turns off creation of route table for transit gateways. | `bool` | `false` | no |
| <a name="input_flow_logs_bucket"></a> [flow\_logs\_bucket](#input\_flow\_logs\_bucket) | Bucket arn for flow logs | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | name of the tgw | `string` | n/a | yes |
| <a name="input_vpc_attachment_id_map"></a> [vpc\_attachment\_id\_map](#input\_vpc\_attachment\_id\_map) | List of VPC attachment IDs | `map(any)` | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->