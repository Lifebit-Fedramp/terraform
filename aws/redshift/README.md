# terraform-aws-redshift
Terraform aws redshift module for commercial and govcloud accounts.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_redshift"></a> [redshift](#module\_redshift) | terraform-aws-modules/redshift/aws | 5.0.0 |
| <a name="module_redshift_kms_key"></a> [redshift\_kms\_key](#module\_redshift\_kms\_key) | terraform-aws-modules/kms/aws | 1.5.0 |
| <a name="module_redshift_vpc_security_group"></a> [redshift\_vpc\_security\_group](#module\_redshift\_vpc\_security\_group) | terraform-aws-modules/security-group/aws//modules/redshift | ~> 4.0 |

## Resources

| Name | Type |
|------|------|
| [random_password.redshift_master_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_string.redshift_master_username](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the cluster | `string` | n/a | yes |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | The name of the Redshift database | `string` | `"uat"` | no |
| <a name="input_key_administrator_arn"></a> [key\_administrator\_arn](#input\_key\_administrator\_arn) | The ARN of the KMS key administrator | `string` | n/a | yes |
| <a name="input_logging_bucket"></a> [logging\_bucket](#input\_logging\_bucket) | The bucket to log to when logging is enabled | `string` | n/a | yes |
| <a name="input_logging_enabled"></a> [logging\_enabled](#input\_logging\_enabled) | Whether or not logging is enabled | `bool` | `true` | no |
| <a name="input_node_type"></a> [node\_type](#input\_node\_type) | The node type of the Redshift database | `string` | `"dc2.large"` | no |
| <a name="input_number_of_nodes"></a> [number\_of\_nodes](#input\_number\_of\_nodes) | The number of nodes for the Redshift database | `number` | `1` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | The AWS Subnet IDs for Redshift | `list(string)` | n/a | yes |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | The CIDR block for the VPC | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPC ID for Redshift | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->