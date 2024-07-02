# terraform-aws-eks
Security-Hardened Terraform Module with EKS

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.22 |
| <a name="requirement_github"></a> [github](#requirement\_github) | ~> 4.27 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.7 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.14 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.12 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.22 |
| <a name="provider_aws.sharedservices"></a> [aws.sharedservices](#provider\_aws.sharedservices) | >= 4.22 |
| <a name="provider_github"></a> [github](#provider\_github) | ~> 4.27 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | >= 2.7 |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | >= 1.14 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | ~> 2.12 |
| <a name="provider_template"></a> [template](#provider\_template) | n/a |
| <a name="provider_tls"></a> [tls](#provider\_tls) | ~> 3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aws_load_balancer_controller_irsa"></a> [aws\_load\_balancer\_controller\_irsa](#module\_aws\_load\_balancer\_controller\_irsa) | terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | 5.2.0 |
| <a name="module_cluster_autoscaler_irsa"></a> [cluster\_autoscaler\_irsa](#module\_cluster\_autoscaler\_irsa) | terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | 5.2.0 |
| <a name="module_eks"></a> [eks](#module\_eks) | terraform-aws-modules/eks/aws | ~> 19.5 |
| <a name="module_external_secrets_irsa"></a> [external\_secrets\_irsa](#module\_external\_secrets\_irsa) | terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | 5.2.0 |
| <a name="module_spacelift_irsa"></a> [spacelift\_irsa](#module\_spacelift\_irsa) | terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | 5.2.0 |

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acmpca_certificate.cluster_intermediate_ca_1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acmpca_certificate) | resource |
| [aws_acmpca_certificate.wildcard](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acmpca_certificate) | resource |
| [aws_iam_policy.alb_ingress_controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.cluster_autoscaler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.external_secrets_operator](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.image_builder_kms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_kms_key.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_secretsmanager_secret.wildcard](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.wildcard](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [github_repository_file.apps](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.components](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.credentials](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.dot_keep_files](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.infrastructure](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.kustomization](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.peer_authenitcation_policy](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.sources](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.sync](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.tls_12_minimum](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [helm_release.istio](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubectl_manifest.install_components](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubectl_manifest.install_sync](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubernetes_namespace.flux_system](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.istio_gateways](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.istio_system](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_secret.cluster_intermediate_ca_1](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_secret.flux_sync_repository_credentials](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_secret.wildcard](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_secret.wildcard_gateways](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [tls_cert_request.cluster_intermediate_ca_1](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/cert_request) | resource |
| [tls_cert_request.wildcard](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/cert_request) | resource |
| [aws_acmpca_certificate.root](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/acmpca_certificate) | data source |
| [aws_acmpca_certificate_authority.root](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/acmpca_certificate_authority) | data source |
| [aws_ami.eks_worker](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_eks_cluster_auth.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster_auth) | data source |
| [aws_iam_policy_document.cluster_autoscaler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.external_secrets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.image_builder_kms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.load_balancer_controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_roles.sso_administratoraccess](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_roles) | data source |
| [aws_iam_roles.sso_cloudnexaaccess](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_roles) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_partition.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_region.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_secretsmanager_secret_version.github_creds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |
| [github_repository.flux_sync](https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/repository) | data source |
| [kubectl_file_documents.components](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/data-sources/file_documents) | data source |
| [kubectl_file_documents.sync](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/data-sources/file_documents) | data source |
| [template_file.apps](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [template_file.credentials](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [template_file.infrastructure](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [template_file.sync](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_name"></a> [account\_name](#input\_account\_name) | Name of the account this cluster belongs to | `string` | n/a | yes |
| <a name="input_additional_kubectl_access"></a> [additional\_kubectl\_access](#input\_additional\_kubectl\_access) | Additional users to add to the kubectl config | <pre>list(object({<br>    rolearn  = string<br>    groups   = list(string)<br>    username = string<br>  }))</pre> | `[]` | no |
| <a name="input_additional_node_security_group_rules"></a> [additional\_node\_security\_group\_rules](#input\_additional\_node\_security\_group\_rules) | Additional security group rules to add to the node security group | `map(any)` | `{}` | no |
| <a name="input_additional_self_managed_node_groups"></a> [additional\_self\_managed\_node\_groups](#input\_additional\_self\_managed\_node\_groups) | Additional self managed node groups to create | `any` | `{}` | no |
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | override AMI ID to use for the cluster | `string` | `""` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the cluster | `string` | n/a | yes |
| <a name="input_cluster_version"></a> [cluster\_version](#input\_cluster\_version) | Kubernetes version to use for the cluster | `string` | `"1.23"` | no |
| <a name="input_control_plane_allowed_cidrs"></a> [control\_plane\_allowed\_cidrs](#input\_control\_plane\_allowed\_cidrs) | List of CIDRs to allow access to the control plane | `list(string)` | `[]` | no |
| <a name="input_dns_name"></a> [dns\_name](#input\_dns\_name) | DNS name to use for the cluster | `string` | n/a | yes |
| <a name="input_enable_cluster_addons"></a> [enable\_cluster\_addons](#input\_enable\_cluster\_addons) | Boolean for whether to manage eks addons with terraform / EKS | `bool` | `false` | no |
| <a name="input_enable_cluster_autoscaler_oidc"></a> [enable\_cluster\_autoscaler\_oidc](#input\_enable\_cluster\_autoscaler\_oidc) | Enable if cluster autoscaler is in this cluster | `bool` | `true` | no |
| <a name="input_enable_external_secrets"></a> [enable\_external\_secrets](#input\_enable\_external\_secrets) | Enable external secrets | `bool` | `true` | no |
| <a name="input_enable_lb_controller_oidc"></a> [enable\_lb\_controller\_oidc](#input\_enable\_lb\_controller\_oidc) | Enable if alb ingress controller is in this cluster | `bool` | `false` | no |
| <a name="input_enable_spacelift_oidc"></a> [enable\_spacelift\_oidc](#input\_enable\_spacelift\_oidc) | Enable if spacelift is in this cluster | `bool` | `false` | no |
| <a name="input_flux_repo_name"></a> [flux\_repo\_name](#input\_flux\_repo\_name) | Name of the Flux repo | `string` | `"kubernetes-clusters"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance type to use for the cluster | `string` | `"t3a.xlarge"` | no |
| <a name="input_mng_desired_size"></a> [mng\_desired\_size](#input\_mng\_desired\_size) | Desired number of nodes in the managed node group | `number` | `3` | no |
| <a name="input_mng_max_size"></a> [mng\_max\_size](#input\_mng\_max\_size) | Maximum number of nodes in the managed node group | `number` | `3` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | Subnet IDs to use for the cluster | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | EKS tags | `map(string)` | `{}` | no |
| <a name="input_volume_size"></a> [volume\_size](#input\_volume\_size) | Size of the EBS volume to use for the cluster | `number` | `20` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID to use for the cluster | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_certificate_authority_data"></a> [cluster\_certificate\_authority\_data](#output\_cluster\_certificate\_authority\_data) | n/a |
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | n/a |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | n/a |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | n/a |
| <a name="output_cluster_oidc_issuer_url"></a> [cluster\_oidc\_issuer\_url](#output\_cluster\_oidc\_issuer\_url) | n/a |
| <a name="output_cluster_sg"></a> [cluster\_sg](#output\_cluster\_sg) | n/a |
| <a name="output_node_groups_sg_id"></a> [node\_groups\_sg\_id](#output\_node\_groups\_sg\_id) | n/a |
| <a name="output_node_iam_role_arn"></a> [node\_iam\_role\_arn](#output\_node\_iam\_role\_arn) | n/a |
| <a name="output_oidc_provider_arn"></a> [oidc\_provider\_arn](#output\_oidc\_provider\_arn) | n/a |
| <a name="output_self_managed_node_groups"></a> [self\_managed\_node\_groups](#output\_self\_managed\_node\_groups) | Map of attribute maps for all self managed node groups created |
<!-- END_TF_DOCS -->