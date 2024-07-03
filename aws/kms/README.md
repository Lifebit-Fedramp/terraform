# terraform-aws-kms
Terraform aws kms module for commercial and govcloud accounts.

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
| [aws_kms_alias.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_replica_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_replica_key) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alias"></a> [alias](#input\_alias) | n/a | `string` | `"alias/shared-ebs-default"` | no |
| <a name="input_aliases"></a> [aliases](#input\_aliases) | A list of aliases to create. Must not be computed values. | `string` | `""` | no |
| <a name="input_cmk_encryption"></a> [cmk\_encryption](#input\_cmk\_encryption) | Encryption to be used, i.e. SYMMETRIC\_DEFAULT, RSA\_2048, RSA\_4096, ECC\_NIST\_P256, etc. | `string` | `"SYMMETRIC_DEFAULT"` | no |
| <a name="input_deletion_window"></a> [deletion\_window](#input\_deletion\_window) | Amount of time before CMK is deletd in days. | `number` | `30` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of the KMS Key. | `string` | `""` | no |
| <a name="input_is_replica"></a> [is\_replica](#input\_is\_replica) | Determines if the key is a replica. | `bool` | `false` | no |
| <a name="input_key_enabled"></a> [key\_enabled](#input\_key\_enabled) | Specifies whether the key is enabled. | `bool` | `true` | no |
| <a name="input_key_usage"></a> [key\_usage](#input\_key\_usage) | Specifies the intended use of the key. | `string` | `"ENCRYPT_DECRYPT"` | no |
| <a name="input_multi_region"></a> [multi\_region](#input\_multi\_region) | Indicates whether the KMS key is a multi-Region or regional key. | `bool` | `false` | no |
| <a name="input_policy"></a> [policy](#input\_policy) | n/a | `any` | `null` | no |
| <a name="input_primary_key_arn"></a> [primary\_key\_arn](#input\_primary\_key\_arn) | The primary key arn of a multi-region replica key. | `string` | `null` | no |
| <a name="input_rotation_enabled"></a> [rotation\_enabled](#input\_rotation\_enabled) | Specifies whether key rotation is enabled. | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags for the KMS key. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kms_key_arn"></a> [kms\_key\_arn](#output\_kms\_key\_arn) | n/a |
| <a name="output_kms_key_id"></a> [kms\_key\_id](#output\_kms\_key\_id) | n/a |
<!-- END_TF_DOCS -->