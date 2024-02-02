data "aws_region" "this" {}

locals {
  cluster_repo_path = "${data.aws_region.this.name}/${var.account_name}/${var.cluster_name}"
  admin_sso_users = tolist(data.aws_iam_roles.sso_administratoraccess.arns)
}
