# terraform-aws-mq
Terraform aws mq module for commercial and govcloud accounts.

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
| [aws_mq_broker.broker](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/mq_broker) | resource |
| [aws_secretsmanager_secret.mq-credentials](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret.mq-uri](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.mq-credentials](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_secretsmanager_secret_version.mq-uri](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_security_group.mq](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [random_id.id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [random_password.mq](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_subnet.app_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnet.mq_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_subnet_ids"></a> [app\_subnet\_ids](#input\_app\_subnet\_ids) | n/a | `any` | n/a | yes |
| <a name="input_broker_user"></a> [broker\_user](#input\_broker\_user) | n/a | `string` | `"example_user"` | no |
| <a name="input_deployment_mode"></a> [deployment\_mode](#input\_deployment\_mode) | The deployment mode of the broker. Supported: SINGLE\_INSTANCE, ACTIVE\_STANDBY\_MULTI\_AZ and CLUSTER\_MULTI\_AZ. | `string` | `"CLUSTER_MULTI_AZ"` | no |
| <a name="input_engine_type"></a> [engine\_type](#input\_engine\_type) | n/a | `string` | `"RabbitMQ"` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | n/a | `string` | `"3.9.16"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | n/a | `string` | `"mq.m5.large"` | no |
| <a name="input_mq_broker_apply_immediately"></a> [mq\_broker\_apply\_immediately](#input\_mq\_broker\_apply\_immediately) | Specifies whether any cluster modifications are applied immediately, or during the next maintenance window. | `bool` | `true` | no |
| <a name="input_mq_broker_auto_minor_version_upgrade"></a> [mq\_broker\_auto\_minor\_version\_upgrade](#input\_mq\_broker\_auto\_minor\_version\_upgrade) | Enables automatic upgrades to new minor versions for brokers, as Apache releases the versions. | `bool` | `true` | no |
| <a name="input_mq_broker_logs_audit"></a> [mq\_broker\_logs\_audit](#input\_mq\_broker\_logs\_audit) | Enables audit logging. User management action made using JMX or the ActiveMQ Web Console is logged. | `bool` | `false` | no |
| <a name="input_mq_broker_logs_general"></a> [mq\_broker\_logs\_general](#input\_mq\_broker\_logs\_general) | Enables general logging via CloudWatch | `bool` | `false` | no |
| <a name="input_mq_broker_maintenance_day_of_week"></a> [mq\_broker\_maintenance\_day\_of\_week](#input\_mq\_broker\_maintenance\_day\_of\_week) | The maintenance day of the week. e.g. MONDAY, TUESDAY, or WEDNESDAY. | `string` | `"SUNDAY"` | no |
| <a name="input_mq_broker_maintenance_time_of_day"></a> [mq\_broker\_maintenance\_time\_of\_day](#input\_mq\_broker\_maintenance\_time\_of\_day) | The maintenance time, in 24-hour format. e.g. 02:00. | `string` | `"03:00"` | no |
| <a name="input_mq_broker_maintenance_time_zone"></a> [mq\_broker\_maintenance\_time\_zone](#input\_mq\_broker\_maintenance\_time\_zone) | The maintenance time zone, in either the Country/City format, or the UTC offset format. e.g. CET. | `string` | `"UTC"` | no |
| <a name="input_mq_broker_tags"></a> [mq\_broker\_tags](#input\_mq\_broker\_tags) | A mapping of tags to assign to the resources. | `map(string)` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `any` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | n/a | `any` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `any` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->