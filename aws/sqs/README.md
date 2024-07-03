# terraform-aws-sqs
Terraform aws sqs module for commercial and govcloud accounts.

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
| [aws_sqs_queue.subscriber_dl_queue](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue.subscriber_queue](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue_policy.subscriber_queue_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dl_queue_name"></a> [dl\_queue\_name](#input\_dl\_queue\_name) | Name of dead letter SQS queue used for messages that fail to be received | `string` | n/a | yes |
| <a name="input_environment_name"></a> [environment\_name](#input\_environment\_name) | Name of the Environment in K8s | `string` | n/a | yes |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | ID of kms key used to encrypt and decrypt messages | `string` | n/a | yes |
| <a name="input_publisher_arn"></a> [publisher\_arn](#input\_publisher\_arn) | ARN of AWS service publishing to queue (e.g. SNS topic or other) | `string` | n/a | yes |
| <a name="input_publisher_service_url"></a> [publisher\_service\_url](#input\_publisher\_service\_url) | URL of AWS service publishing to queue (e.g. sns.amazonaws.com) | `string` | n/a | yes |
| <a name="input_queue_name"></a> [queue\_name](#input\_queue\_name) | Name of SQS queue | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_queue_arn"></a> [queue\_arn](#output\_queue\_arn) | n/a |
| <a name="output_queue_url"></a> [queue\_url](#output\_queue\_url) | n/a |
<!-- END_TF_DOCS -->