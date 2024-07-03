# terraform-aws-ssm
Terraform aws ssm parameter module for commercial and govcloud accounts.

To create a SecureString parameter, pass in an empty string for the value. The module sets the value to `<placeholder>` and
once the parameter has been created, the value must be manually populated through the AWS Console.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.32.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.32.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ssm_parameter.parameter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | Name of the environment | `string` | `""` | no |
| <a name="input_identifier"></a> [identifier](#input\_identifier) | Identifier for the group of SSM Parameters | `string` | `""` | no |
| <a name="input_key_id"></a> [key\_id](#input\_key\_id) | ID of KMS key to encrypt SecureStrings with | `string` | `""` | no |
| <a name="input_path_prefix"></a> [path\_prefix](#input\_path\_prefix) | Path prefix to use for SSM Parameters | `string` | `""` | no |
| <a name="input_ssm_parameters"></a> [ssm\_parameters](#input\_ssm\_parameters) | Map of SSM Parameters to create | `any` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_parameters"></a> [parameters](#output\_parameters) | Map of Parameters created |
<!-- END_TF_DOCS -->