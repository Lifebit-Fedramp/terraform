# terraform-aws-secrets-manager
Terraform aws secrets-manager module for commercial and govcloud accounts.

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
| [aws_secretsmanager_secret.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_policy) | resource |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_role_arn_list"></a> [account\_role\_arn\_list](#input\_account\_role\_arn\_list) | List of Account ARNs with access to Secret | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_allow_cross_account_access"></a> [allow\_cross\_account\_access](#input\_allow\_cross\_account\_access) | Boolean for whether to use KMS key encryption | `bool` | `false` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of the resource | `string` | n/a | yes |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | ID or ARN of KMS Key used to encrypt | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the resource | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_secret_id"></a> [secret\_id](#output\_secret\_id) | n/a |
<!-- END_TF_DOCS -->