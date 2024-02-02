# kics-scan ignore-block
resource "aws_kms_key" "eks" {
  description         = "EKS KMS Key for ${var.cluster_name}"
  enable_key_rotation = true
}
