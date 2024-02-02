resource "aws_acm_certificate" "this" {
  domain_name       = "*.${var.dns_name}"
  validation_method = "DNS"

  tags = {
    Environment = var.account_name
  }

  lifecycle {
    create_before_destroy = true
  }
}
