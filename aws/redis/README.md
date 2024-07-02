# terraform-aws-redis
Terraform aws redis module for commercial and govcloud accounts.

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
| [aws_elasticache_parameter_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_parameter_group) | resource |
| [aws_elasticache_replication_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_replication_group) | resource |
| [aws_elasticache_subnet_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_subnet_group) | resource |
| [aws_secretsmanager_secret.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.allow_cidr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_sgs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.egress_cidr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.egress_sgs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apply_immediately"></a> [apply\_immediately](#input\_apply\_immediately) | Specifies whether any modifications are applied immediately, or during the next maintenance window. | `bool` | `false` | no |
| <a name="input_at_rest_encryption_enabled"></a> [at\_rest\_encryption\_enabled](#input\_at\_rest\_encryption\_enabled) | Whether to enable encryption at rest. | `bool` | `true` | no |
| <a name="input_automatic_failover_enabled"></a> [automatic\_failover\_enabled](#input\_automatic\_failover\_enabled) | Specifies whether a read-only replica will be automatically promoted to read/write primary if the existing primary fails. | `bool` | `true` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | Region | `string` | `"us-east-1"` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of the all resources. | `string` | `"Managed by Terraform"` | no |
| <a name="input_egress_cidr_blocks"></a> [egress\_cidr\_blocks](#input\_egress\_cidr\_blocks) | List of egress CIDR blocks. | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_egress_sgs"></a> [egress\_sgs](#input\_egress\_sgs) | List of egress SGs. | `list(string)` | `[]` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | The version number of the cache engine to be used for the cache clusters in this replication group. | `string` | `"6.2"` | no |
| <a name="input_family"></a> [family](#input\_family) | The family of the ElastiCache parameter group. | `string` | `"redis6.x"` | no |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | Specifies the weekly time range for when maintenance on the cache cluster is performed. | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | The replication group identifier. This parameter is stored as a lowercase string. | `string` | n/a | yes |
| <a name="input_node_type"></a> [node\_type](#input\_node\_type) | The compute and memory capacity of the nodes in the node group. | `string` | `"cache.m5.large"` | no |
| <a name="input_num_cache_clusters"></a> [num\_cache\_clusters](#input\_num\_cache\_clusters) | The number of cache clusters (primary and replicas) this replication group will have. | `string` | `2` | no |
| <a name="input_port"></a> [port](#input\_port) | The port number on which each of the cache nodes will accept connections. | `number` | `6379` | no |
| <a name="input_snapshot_retention_limit"></a> [snapshot\_retention\_limit](#input\_snapshot\_retention\_limit) | The number of days for which ElastiCache will retain automatic cache cluster snapshots before deleting them. | `number` | `30` | no |
| <a name="input_snapshot_window"></a> [snapshot\_window](#input\_snapshot\_window) | The daily time range (in UTC) during which ElastiCache will begin taking a daily snapshot of your cache cluster. | `string` | `""` | no |
| <a name="input_source_cidr_blocks"></a> [source\_cidr\_blocks](#input\_source\_cidr\_blocks) | List of source CIDR blocks. | `list(string)` | `[]` | no |
| <a name="input_source_sgs"></a> [source\_sgs](#input\_source\_sgs) | List of source SGs. | `list(string)` | `[]` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of VPC Subnet IDs for the cache subnet group. | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to all resources. | `map(string)` | `{}` | no |
| <a name="input_transit_encryption_enabled"></a> [transit\_encryption\_enabled](#input\_transit\_encryption\_enabled) | Whether to enable encryption in transit. | `bool` | `true` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC Id to associate with Redis ElastiCache. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_elasticache_replication_group_id"></a> [elasticache\_replication\_group\_id](#output\_elasticache\_replication\_group\_id) | The ID of the ElastiCache Replication Group. |
| <a name="output_elasticache_replication_group_member_clusters"></a> [elasticache\_replication\_group\_member\_clusters](#output\_elasticache\_replication\_group\_member\_clusters) | The identifiers of all the nodes that are part of this replication group. |
| <a name="output_elasticache_replication_group_primary_endpoint_address"></a> [elasticache\_replication\_group\_primary\_endpoint\_address](#output\_elasticache\_replication\_group\_primary\_endpoint\_address) | The address of the endpoint for the primary node in the replication group. |
<!-- END_TF_DOCS -->