data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_name
}

data "aws_iam_roles" "sso_administratoraccess" {
  name_regex  = "AWSReservedSSO_AdministratorAccess_.*"
  path_prefix = "/aws-reserved/sso.amazonaws.com/"
}

data "aws_partition" "current" {}

data "aws_iam_roles" "sso_cloudnexaaccess" {
  name_regex  = "AWSReservedSSO_CloudnexaAccess_.*"
  path_prefix = "/aws-reserved/sso.amazonaws.com/"
}

data "aws_caller_identity" "current" {}

data "aws_ami" "eks_worker" {
  most_recent = true

  filter {
    name   = "name"
    values = ["text-*"]
  }

  owners = ["<account>"]
}

data "aws_acmpca_certificate_authority" "root" {
  provider = aws.sharedservices
  arn      = "<arn>"
}

data "aws_acmpca_certificate" "root" {
  provider                  = aws.sharedservices
  certificate_authority_arn = data.aws_acmpca_certificate_authority.root.arn
  arn                       = "<arn>"
}

data "aws_partition" "this" {}
