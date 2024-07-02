# terraform-aws-iam
Terraform aws iam module for commercial and govcloud accounts.

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
| [aws_accessanalyzer_analyzer.analyzer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/accessanalyzer_analyzer) | resource |
| [aws_iam_account_password_policy.commercial](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_account_password_policy) | resource |
| [aws_iam_account_password_policy.govcloud](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_account_password_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_analyzer"></a> [enable\_analyzer](#input\_enable\_analyzer) | Variable used to enable/disable access analyzer in an account | `bool` | `false` | no |
| <a name="input_password_policy"></a> [password\_policy](#input\_password\_policy) | Variable used to enable/disable password policies in an account | `bool` | `true` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->