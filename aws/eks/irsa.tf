module "external_secrets_irsa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "5.2.0"

  count = var.enable_external_secrets ? 1 : 0

  role_name        = "${var.cluster_name}-external-secrets"
  role_policy_arns = { "ExternalSecrets" : aws_iam_policy.external_secrets_operator[count.index].arn }

  oidc_providers = {
    main = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["external-secrets:external-secrets"]
    }
  }
}

module "spacelift_irsa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "5.2.0"

  count = var.enable_spacelift_oidc ? 1 : 0

  role_name        = "<role_name>"
  role_policy_arns = { "<role_name>" : "<role_arn>" }

  oidc_providers = {
    main = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["<namespace>:<service_account>"]
    }
  }
}


module "aws_load_balancer_controller_irsa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "5.2.0"

  count = var.enable_lb_controller_oidc ? 1 : 0

  role_name = "${var.cluster_name}-albc"

  # https://github.com/kubernetes-sigs/aws-load-balancer-controller/issues/2692
  # the above github issue is why we are rolling this policy ourselves.
  role_policy_arns = { "LOAD_BALANCER" : aws_iam_policy.alb_ingress_controller[count.index].arn }

  oidc_providers = {
    main = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:aws-load-balancer-controller"]
    }
  }
}

module "cluster_autoscaler_irsa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "5.2.0"

  count = var.enable_cluster_autoscaler_oidc ? 1 : 0

  role_name        = "${var.cluster_name}-cluster-autoscaler"
  role_policy_arns = { "ExternalSecrets" : aws_iam_policy.cluster_autoscaler[count.index].arn }

  oidc_providers = {
    main = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["cluster-autoscaler:cluster-autoscaler"]
    }
  }
}
