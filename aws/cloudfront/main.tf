module "cdn" {
  source = "terraform-aws-modules/cloudfront/aws"
  version = "3.2.0"

  aliases = var.aliases

  enabled             = true
  retain_on_delete    = false
  wait_for_deployment = false

  create_origin_access_identity = true
  origin_access_identities = {
    s3_bucket = var.domain_name
  }

  logging_config = {
    bucket = "<text>-${var.domain_name}"
  }

  origin = {
    s3_one = {
      domain_name = var.domain_name
      s3_origin_config = {
        origin_access_identity = "s3_bucket"
      }
    }
  }

  default_cache_behavior = {
    target_origin_id       = var.domain_name
    viewer_protocol_policy = "allow-all"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]
    compress        = true
    query_string    = true
  }
}
