# terraform-aws-lambda
Terraform aws lambda module for commercial and govcloud accounts.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_lambda_function"></a> [lambda\_function](#module\_lambda\_function) | terraform-aws-modules/lambda/aws | 4.16.0 |
| <a name="module_lambda_kms_key"></a> [lambda\_kms\_key](#module\_lambda\_kms\_key) | terraform-aws-modules/kms/aws | 1.5.0 |
| <a name="module_lambda_new_sns_topic"></a> [lambda\_new\_sns\_topic](#module\_lambda\_new\_sns\_topic) | spacelift.hscinternal.com/<org>/sns/aws | 1.0.0 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.lambda_event_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_rule.lambda_schedule_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.lambda_event_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_cloudwatch_event_target.lambda_schedule_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_cloudwatch_log_metric_filter.error_log_metric_filter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_metric_filter) | resource |
| [aws_cloudwatch_metric_alarm.lambda-alarm-handled-exceptions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.lambda-alarm-unhandled-exceptions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_lambda_permission.allow_cloudwatch_event_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_lambda_permission.allow_cloudwatch_schedule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_lambda_permission.allow_existing_sns_invoke](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_lambda_permission.allow_new_sns_invoke](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_sns_topic_subscription.lambda_existing_sns_subscription](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [aws_sns_topic_subscription.lambda_new_sns_subscription](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.lambda_trust_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | Description of the lambda function. | `string` | `""` | no |
| <a name="input_environment_variables"></a> [environment\_variables](#input\_environment\_variables) | Environmental variables for lambda use. | `map(string)` | `{}` | no |
| <a name="input_event_pattern"></a> [event\_pattern](#input\_event\_pattern) | The job frequency, using event patterns (link above) | `string` | `""` | no |
| <a name="input_function_name"></a> [function\_name](#input\_function\_name) | Name of the lambda function. This should match the file name of the main lambda file without the file extensions. E.G. if the lambda name is MyLambda, the main lambda file to invoke inside the deployment package should be MyLambda.py | `string` | n/a | yes |
| <a name="input_handler_file"></a> [handler\_file](#input\_handler\_file) | Name of the lambda handler file. | `string` | `"lambda_function"` | no |
| <a name="input_handler_function"></a> [handler\_function](#input\_handler\_function) | Name of the lambda handler function excluding the filename. If your lambda function is named lambda\_function and invocation should call lambda\_handler(), this value would be lambda\_handler | `string` | `"lambda_handler"` | no |
| <a name="input_health_monitor_log_level"></a> [health\_monitor\_log\_level](#input\_health\_monitor\_log\_level) | Handled exceptions log level to alarm on. | `string` | `"ERROR"` | no |
| <a name="input_health_monitor_sns_topic"></a> [health\_monitor\_sns\_topic](#input\_health\_monitor\_sns\_topic) | SNS Topic to send handled/unhandled exception messages to. Handled exception default is alarm on ERROR log levels. | `string` | n/a | yes |
| <a name="input_lambda_event_pattern_description"></a> [lambda\_event\_pattern\_description](#input\_lambda\_event\_pattern\_description) | n/a | `string` | `"Schedule for Lambda Function."` | no |
| <a name="input_lambda_schedule_description"></a> [lambda\_schedule\_description](#input\_lambda\_schedule\_description) | n/a | `string` | `"Schedule for Lambda Function."` | no |
| <a name="input_memory_size"></a> [memory\_size](#input\_memory\_size) | Memory allocated to Lambda invocations. | `number` | `"128"` | no |
| <a name="input_policies"></a> [policies](#input\_policies) | list of IAM policy ARNs to attach to lambda role. Only attaches to role when length > 0 | `list(string)` | <pre>[<br>  "arn:aws-us-gov:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"<br>]</pre> | no |
| <a name="input_policy_jsons"></a> [policy\_jsons](#input\_policy\_jsons) | List of additional policy documents as JSON to attach to Lambda Function role | `list(string)` | `[]` | no |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | Lambda function runtime from list defined at https://docs.aws.amazon.com/lambda/latest/dg/lambda-runtimes.html | `string` | `"python3.9"` | no |
| <a name="input_s3_bucket"></a> [s3\_bucket](#input\_s3\_bucket) | Lambda function runtime from list defined at https://docs.aws.amazon.com/lambda/latest/dg/lambda-runtimes.html | `string` | `"lambda-deployment-pkgs"` | no |
| <a name="input_schedule_expression"></a> [schedule\_expression](#input\_schedule\_expression) | The job frequency, using schedule expressions (link in comments above) | `string` | `"rate(1 day)"` | no |
| <a name="input_sns_existing_topic_name"></a> [sns\_existing\_topic\_name](#input\_sns\_existing\_topic\_name) | name of existing SNS topic to subscribe lambda to | `string` | `""` | no |
| <a name="input_sns_new_topic_name"></a> [sns\_new\_topic\_name](#input\_sns\_new\_topic\_name) | Name to give new SNS topic and subscribe lambda function to it | `string` | `""` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Maximum runtime per invocation. Maximum value allowed is 900 (15 minutes). | `number` | `"900"` | no |
| <a name="input_trigger_lambda_by_cloudwatch_event_rule"></a> [trigger\_lambda\_by\_cloudwatch\_event\_rule](#input\_trigger\_lambda\_by\_cloudwatch\_event\_rule) | n/a | `bool` | `false` | no |
| <a name="input_trigger_lambda_by_schedule"></a> [trigger\_lambda\_by\_schedule](#input\_trigger\_lambda\_by\_schedule) | n/a | `bool` | `false` | no |
| <a name="input_trigger_lambda_by_sns"></a> [trigger\_lambda\_by\_sns](#input\_trigger\_lambda\_by\_sns) | n/a | `bool` | `false` | no |
| <a name="input_vpc_security_group_ids"></a> [vpc\_security\_group\_ids](#input\_vpc\_security\_group\_ids) | If Lambda requires VPC access, list of security group IDs. | `list(string)` | `[]` | no |
| <a name="input_vpc_subnet_ids"></a> [vpc\_subnet\_ids](#input\_vpc\_subnet\_ids) | If Lambda requires VPC access, list of subnet IDs. | `list(string)` | `[]` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->