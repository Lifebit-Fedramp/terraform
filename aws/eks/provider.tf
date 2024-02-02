terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = ">= 4.22"
      configuration_aliases = [aws, aws.sharedservices]
    }

    github = {
      source  = "integrations/github"
      version = "~> 4.27"
    }

    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.14"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.12"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 3.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.7"
    }
  }
}

provider "kubectl" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.cluster.token

  load_config_file = false
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.cluster.token

  experiments {
    manifest_resource = true
  }
}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}
