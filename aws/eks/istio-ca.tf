resource "aws_acmpca_certificate" "cluster_intermediate_ca_1" {
  certificate_authority_arn   = data.aws_acmpca_certificate_authority.root.arn
  certificate_signing_request = tls_cert_request.cluster_intermediate_ca_1.cert_request_pem
  signing_algorithm           = "SHA512WITHRSA"

  template_arn = "arn:${data.aws_partition.this.partition}:acm-pca:::<arn>"

  validity {
    type  = "YEARS"
    value = 10
  }
}

resource "tls_cert_request" "cluster_intermediate_ca_1" {
  private_key_pem = file("/mnt/workspace/<pemfile>.pem")

  subject {
    common_name         = "Cluster ${var.cluster_name} Intermediate CA 1"
    organizational_unit = "<org>"
  }
}

resource "kubernetes_secret" "cluster_intermediate_ca_1" {
  metadata {
    name      = "cacerts"
    namespace = kubernetes_namespace.istio_system.id
  }

  data = {
    "root-cert.pem"  = data.aws_acmpca_certificate_authority.root.certificate,
    "cert-chain.pem" = aws_acmpca_certificate.cluster_intermediate_ca_1.certificate,
    "ca-cert.pem"    = aws_acmpca_certificate.cluster_intermediate_ca_1.certificate,
    "ca-key.pem"     = file("/mnt/workspace/<pemfile>.pem"),
  }
}
