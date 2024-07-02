# terraform-aws-security-hub
Terraform aws security hub module for commercial and govcloud accounts.

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
| [aws_securityhub_account.security_hub](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_account) | resource |
| [aws_securityhub_standards_subscription.standard](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/securityhub_standards_subscription) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_security_hub_resource"></a> [create\_security\_hub\_resource](#input\_create\_security\_hub\_resource) | Whether or not security hub should be enabled in this region | `bool` | `false` | no |
| <a name="input_is_govcloud"></a> [is\_govcloud](#input\_is\_govcloud) | Whether or not this is deployed in GovCloud. This affects the arn of the standards being used. | `bool` | `true` | no |
| <a name="input_security_hub_standards"></a> [security\_hub\_standards](#input\_security\_hub\_standards) | A group of controls that constitute requirements | `list(string)` | <pre>[<br>  "standards/aws-foundational-security-best-practices/v/1.0.0",<br>  "standards/cis-aws-foundations-benchmark/v/1.4.0"<br>]</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->