locals {
  redshift_cluster_name = var.cluster_name
}

module "redshift" {
  source  = "terraform-aws-modules/redshift/aws"
  version = "5.0.0"

  cluster_identifier = local.redshift_cluster_name
  database_name      = var.database_name

  allow_version_upgrade = true
  node_type             = var.node_type
  number_of_nodes       = var.number_of_nodes

  master_username        = random_string.redshift_master_username.result
  master_password        = random_password.redshift_master_password.result
  create_random_password = false

  encrypted   = true
  kms_key_arn = module.redshift_kms_key.key_arn

  enhanced_vpc_routing   = true
  subnet_group_name      = local.redshift_cluster_name
  subnet_ids             = var.subnet_ids
  vpc_security_group_ids = [module.redshift_vpc_security_group.security_group_id]

  availability_zone_relocation_enabled = false

  create_endpoint_access = false
  skip_final_snapshot    = true

  create_snapshot_schedule            = true
  snapshot_schedule_identifier        = local.redshift_cluster_name
  use_snapshot_identifier_prefix      = true
  snapshot_schedule_description       = "Snapshot schedule for ${local.redshift_cluster_name}"
  snapshot_schedule_definitions       = ["rate(24 hours)"]
  snapshot_schedule_force_destroy     = true
  automated_snapshot_retention_period = 7

  logging = {
    enable        = var.logging_enabled
    bucket_name   = var.logging_bucket
    s3_key_prefix = "redshift/"
  }

  parameter_group_name = local.redshift_cluster_name

  parameter_group_parameters = {
    enable_user_activity_logging = {
      name  = "enable_user_activity_logging"
      value = true
    }
    require_ssl = {
      name  = "require_ssl"
      value = true
    }
    use_fips_ssl = {
      name  = "use_fips_ssl"
      value = true
    }
  }
}

resource "random_password" "redshift_master_password" {
  length           = 64
  min_lower        = 1
  min_numeric      = 1
  min_special      = 1
  min_upper        = 1
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "random_string" "redshift_master_username" {
  length  = 8
  numeric = false
  special = false
  upper   = false
}
