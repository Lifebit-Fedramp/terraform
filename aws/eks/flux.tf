locals {
  flux_namespace   = "flux-system"
  flux_target_path = "clusters/${local.cluster_repo_path}"
  creds            = jsondecode(data.aws_secretsmanager_secret_version.github_creds.secret_string)
}

resource "kubernetes_namespace" "flux_system" {
  metadata {
    name = local.flux_namespace
    labels = {
      "managed-by"      = "terraform"
      "istio-injection" = "disabled"
    }
  }

  lifecycle {
    ignore_changes = [
      metadata[0].annotations,
      metadata[0].labels,
    ]
  }

  depends_on = [
    helm_release.istio,
  ]
}

data "github_repository" "flux_sync" {
  name = var.flux_repo_name
}

data "aws_secretsmanager_secret_version" "github_creds" {
  provider  = aws.sharedservices
  secret_id = "github-credentials"
}

resource "kubernetes_secret" "flux_sync_repository_credentials" {
  metadata {
    name      = "flux-system"
    namespace = "flux-system"
    labels = {
      "<org>/managed-by" = "terraform"
    }
  }

  data = {
    username = local.creds["username"]
    password = local.creds["password"]
  }

  depends_on = [
    kubectl_manifest.install_components,
    helm_release.istio,
  ]
}

data "template_file" "sync" {
  template = file("${path.module}/manifests/<manifest>.yaml")

  vars = {
    path = "./clusters/${data.aws_region.this.name}/${var.account_name}/${var.cluster_name}"
  }
}

data "template_file" "apps" {
  template = file("${path.module}/manifests/<manifest>.yaml")

  vars = {
    path = "./apps/${data.aws_region.this.name}/${var.account_name}/${var.cluster_name}"
  }
}

data "template_file" "credentials" {
  template = file("${path.module}/manifests/<manifest>.yaml")

  vars = {
    path = "./credentials/${data.aws_region.this.name}/${var.account_name}/${var.cluster_name}/sources"
  }
}

data "template_file" "infrastructure" {
  template = file("${path.module}/manifests/<manifest>.yaml")

  vars = {
    path = "./infrastructure/${data.aws_region.this.name}/${var.account_name}/${var.cluster_name}"
  }
}

data "kubectl_file_documents" "components" {
  content = file("${path.module}/manifests/<manifest>.yaml")
}

data "kubectl_file_documents" "sync" {
  content = data.template_file.sync.rendered
}

resource "kubectl_manifest" "install_components" {
  for_each = data.kubectl_file_documents.components.manifests

  yaml_body = each.value
  depends_on = [
    kubernetes_namespace.flux_system,
    helm_release.istio,
  ]
}

resource "kubectl_manifest" "install_sync" {
  for_each = data.kubectl_file_documents.sync.manifests

  yaml_body = each.value
  depends_on = [
    kubernetes_namespace.flux_system,
    kubectl_manifest.install_components,
    helm_release.istio,
  ]
}

resource "github_repository_file" "tls_12_minimum" {
  overwrite_on_create = true

  repository = data.github_repository.flux_sync.name
  branch     = data.github_repository.flux_sync.default_branch
  content    = file("${path.module}/manifests/<manifest>.yaml")
  file       = "./clusters/${data.aws_region.this.name}/${var.account_name}/${var.cluster_name}/<manifest>.yaml"
}

resource "github_repository_file" "components" {
  overwrite_on_create = true

  repository = data.github_repository.flux_sync.name
  branch     = data.github_repository.flux_sync.default_branch
  content    = file("${path.module}/manifests/<manifest>.yaml")
  file       = "./clusters/${data.aws_region.this.name}/${var.account_name}/${var.cluster_name}/flux-system/<manifest>.yaml"
}

resource "github_repository_file" "sync" {
  overwrite_on_create = true

  repository = data.github_repository.flux_sync.name
  branch     = data.github_repository.flux_sync.default_branch
  content    = data.template_file.sync.rendered
  file       = "./clusters/${data.aws_region.this.name}/${var.account_name}/${var.cluster_name}/flux-system/<manifest>.yaml"
}

resource "github_repository_file" "kustomization" {
  overwrite_on_create = true

  repository = data.github_repository.flux_sync.name
  branch     = data.github_repository.flux_sync.default_branch
  content    = file("${path.module}/manifests/<manifest>.yaml")
  file       = "./clusters/${data.aws_region.this.name}/${var.account_name}/${var.cluster_name}/flux-system/<manifest>.yaml"
}

resource "github_repository_file" "apps" {
  overwrite_on_create = true

  repository = data.github_repository.flux_sync.name
  branch     = data.github_repository.flux_sync.default_branch
  content    = data.template_file.apps.rendered
  file       = "./clusters/${data.aws_region.this.name}/${var.account_name}/${var.cluster_name}/<manifest>.yaml"
}

resource "github_repository_file" "credentials" {
  overwrite_on_create = true

  repository = data.github_repository.flux_sync.name
  branch     = data.github_repository.flux_sync.default_branch
  content    = data.template_file.credentials.rendered
  file       = "./clusters/${data.aws_region.this.name}/${var.account_name}/${var.cluster_name}/<manifest>.yaml"
}

resource "github_repository_file" "infrastructure" {
  overwrite_on_create = true

  repository = data.github_repository.flux_sync.name
  branch     = data.github_repository.flux_sync.default_branch
  content    = data.template_file.infrastructure.rendered
  file       = "./clusters/${data.aws_region.this.name}/${var.account_name}/${var.cluster_name}/<manifest>.yaml"
}

resource "github_repository_file" "sources" {
  overwrite_on_create = true

  repository = data.github_repository.flux_sync.name
  branch     = data.github_repository.flux_sync.default_branch
  content    = file("${path.module}/manifests/<manifest>.yaml")
  file       = "./clusters/${data.aws_region.this.name}/${var.account_name}/${var.cluster_name}/<manifest>.yaml"
}

resource "github_repository_file" "dot_keep_files" {
  for_each = toset([
    "infrastructure/${local.cluster_repo_path}",
    "apps/${local.cluster_repo_path}",
    "credentials/${local.cluster_repo_path}/sources",
  ])

  overwrite_on_create = true

  repository = data.github_repository.flux_sync.name
  branch     = data.github_repository.flux_sync.default_branch
  content    = "# Managed by terraform"
  file       = "${each.key}/.gitkeep"
}

resource "github_repository_file" "peer_authenitcation_policy" {
  overwrite_on_create = true

  repository = data.github_repository.flux_sync.name
  branch     = data.github_repository.flux_sync.default_branch
  content    = file("${path.module}/manifests/<manifest>-policy.yaml")
  file       = "./infrastructure/${local.cluster_repo_path}/<manifest>-policy.yaml"
}
