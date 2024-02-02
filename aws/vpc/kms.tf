resource "aws_kms_key" "flow_logs" {
  description         = "KMS Key for VPC Flow Logs ${var.name}"
  enable_key_rotation = true
}

resource "aws_kms_key" "firewall_logs" {
  description         = "KMS Key for Firewall Logs ${var.name}"
  enable_key_rotation = true
}
