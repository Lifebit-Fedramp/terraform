module "redshift_vpc_security_group" {
  source  = "terraform-aws-modules/security-group/aws//modules/redshift"
  version = "~> 4.0"

  name        = local.redshift_cluster_name
  description = "Redshift security group for ${local.redshift_cluster_name} cluster"
  vpc_id      = var.vpc_id

  # Allow ingress rules to be accessed only within current VPC
  ingress_rules       = ["redshift-tcp"]
  ingress_cidr_blocks = [var.vpc_cidr]

  # Allow all rules for all protocols
  egress_rules = ["all-all"]
}

