# terraform-aws-iam-credential-rotation
Terraform aws iam credential rotation module for commercial and govcloud accounts.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_rotating"></a> [rotating](#requirement\_rotating) | 1.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |
| <a name="provider_rotating"></a> [rotating](#provider\_rotating) | 1.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_access_key.blue](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key) | resource |
| [aws_iam_access_key.green](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key) | resource |
| [aws_iam_user.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [random_pet.blue](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |
| [random_pet.green](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |
| [rotating_blue_green.this](https://registry.terraform.io/providers/Apollorion/rotating/1.0.0/docs/resources/blue_green) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | The name of the user to create. | `string` | n/a | yes |
| <a name="input_rotation_days"></a> [rotation\_days](#input\_rotation\_days) | The number of days before the iam creds are rotated. | `number` | `30` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_active"></a> [active](#output\_active) | n/a |
| <a name="output_arn"></a> [arn](#output\_arn) | n/a |
| <a name="output_blue"></a> [blue](#output\_blue) | n/a |
| <a name="output_green"></a> [green](#output\_green) | n/a |
| <a name="output_name"></a> [name](#output\_name) | n/a |
<!-- END_TF_DOCS -->