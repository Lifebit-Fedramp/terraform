# terraform-aws-aurora
Terraform aws aurora module for commercial and govcloud accounts.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.mysql_rds_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_cloudwatch_log_group.psql_rds_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_db_subnet_group.db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_kms_key.rds_cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_rds_cluster.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster) | resource |
| [aws_rds_cluster_instance.cluster_instances](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_instance) | resource |
| [aws_rds_cluster_parameter_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_parameter_group) | resource |
| [aws_secretsmanager_secret.db-credentials](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.db-credentials](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_security_group.aurora](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [random_id.id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [random_password.db_master_pass](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.rds_cloudwatch_key_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_cidrs"></a> [access\_cidrs](#input\_access\_cidrs) | Additional CIDRs with access to cluster | `list(string)` | `null` | no |
| <a name="input_access_sg_ids"></a> [access\_sg\_ids](#input\_access\_sg\_ids) | Additional Security Group IDs with access to cluster. | `list(string)` | `null` | no |
| <a name="input_backup_retention_period"></a> [backup\_retention\_period](#input\_backup\_retention\_period) | Backup retention period in days | `number` | `30` | no |
| <a name="input_db_cluster_identifier"></a> [db\_cluster\_identifier](#input\_db\_cluster\_identifier) | DB Cluster Identifier | `string` | n/a | yes |
| <a name="input_db_engine"></a> [db\_engine](#input\_db\_engine) | DB Engine | `string` | n/a | yes |
| <a name="input_db_engine_version"></a> [db\_engine\_version](#input\_db\_engine\_version) | DB Engine Version | `string` | n/a | yes |
| <a name="input_db_family"></a> [db\_family](#input\_db\_family) | Database Family | `string` | n/a | yes |
| <a name="input_db_instance_class"></a> [db\_instance\_class](#input\_db\_instance\_class) | DB Instance Class | `string` | `"db.t3.medium"` | no |
| <a name="input_db_instance_count"></a> [db\_instance\_count](#input\_db\_instance\_count) | DB Instance Count | `number` | `2` | no |
| <a name="input_db_master_username"></a> [db\_master\_username](#input\_db\_master\_username) | DB Master Username | `string` | `"admin"` | no |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | DB Name | `string` | n/a | yes |
| <a name="input_db_storage_encrypted"></a> [db\_storage\_encrypted](#input\_db\_storage\_encrypted) | DB Storage Encrypted | `bool` | `true` | no |
| <a name="input_db_subnet_ids"></a> [db\_subnet\_ids](#input\_db\_subnet\_ids) | VPC Subnet IDs | `set(string)` | n/a | yes |
| <a name="input_log_prefix"></a> [log\_prefix](#input\_log\_prefix) | RDS cloudwatch log prefix | `string` | `"/aws/rds/cluster"` | no |
| <a name="input_mysql_log_types"></a> [mysql\_log\_types](#input\_mysql\_log\_types) | Types of mysql RDS logging for cloudwatch log groups | `list(string)` | <pre>[<br>  "general",<br>  "audit",<br>  "slowquery",<br>  "error"<br>]</pre> | no |
| <a name="input_psql_log_types"></a> [psql\_log\_types](#input\_psql\_log\_types) | Types of postgresql RDS logging for cloudwatch log groups | `list(string)` | <pre>[<br>  "postgresql"<br>]</pre> | no |
| <a name="input_serverlessv2_max_capacity"></a> [serverlessv2\_max\_capacity](#input\_serverlessv2\_max\_capacity) | max capacity for serverlessv2 | `number` | `1` | no |
| <a name="input_serverlessv2_min_capacity"></a> [serverlessv2\_min\_capacity](#input\_serverlessv2\_min\_capacity) | min capacity for serverlessv2 | `number` | `0.5` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | RDS tags | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_db_endpoint"></a> [db\_endpoint](#output\_db\_endpoint) | n/a |
| <a name="output_db_master_password"></a> [db\_master\_password](#output\_db\_master\_password) | n/a |
| <a name="output_db_master_username"></a> [db\_master\_username](#output\_db\_master\_username) | n/a |
| <a name="output_db_name"></a> [db\_name](#output\_db\_name) | n/a |
| <a name="output_db_port"></a> [db\_port](#output\_db\_port) | n/a |
| <a name="output_secrets_manager_secret_arn"></a> [secrets\_manager\_secret\_arn](#output\_secrets\_manager\_secret\_arn) | n/a |
| <a name="output_secrets_manager_secret_name"></a> [secrets\_manager\_secret\_name](#output\_secrets\_manager\_secret\_name) | n/a |
<!-- END_TF_DOCS -->