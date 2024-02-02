module "s3" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.14.0"

  bucket        = var.bucket
  force_destroy = false

  attach_policy                         = var.attach_policy
  policy                                = var.attach_policy ? var.policy : null
  attach_deny_insecure_transport_policy = true
  attach_require_latest_tls_policy      = true

  acl                     = var.acl
  block_public_acls       = var.block_public_acls
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  replication_configuration = var.replication_configuration
  server_side_encryption_configuration = var.server_side_encryption_configuration

  versioning = {
    status     = var.versioning_enabled
    mfa_delete = false
  }

  tags = merge(var.tags, { Name = var.bucket })
}
