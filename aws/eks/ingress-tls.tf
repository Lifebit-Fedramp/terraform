resource "aws_acmpca_certificate" "wildcard" {
  certificate_authority_arn   = data.aws_acmpca_certificate_authority.root.arn
  certificate_signing_request = tls_cert_request.wildcard.cert_request_pem
  signing_algorithm           = "SHA512WITHRSA"

  template_arn = "arn:${data.aws_partition.this.partition}:acm-pca:::<template>"

  validity {
    type  = "YEARS"
    value = 2
  }
}

resource "tls_cert_request" "wildcard" {
  private_key_pem = file("<pemfile>.pem")

  subject {
    common_name         = "*.${var.account_name}-<name>"
    organizational_unit = "<organization>"
  }
}

resource "kubernetes_secret" "wildcard" {
  metadata {
    name      = "wildcard"
    namespace = kubernetes_namespace.istio_system.id
  }

  type = "kubernetes.io/tls"

  data = {
    "tls.crt" = aws_acmpca_certificate.wildcard.certificate,
    "tls.key" = file("/mnt/workspace/<pemfile>.pem"),
  }
}

resource "kubernetes_namespace" "istio_gateways" {
  metadata {
    name = "istio-gateways"
    annotations = {
      "istio-injection" = "enabled"
    }
    labels = {
      "policy.sigstore.dev/exclude" : "true"
    }
  }
}

resource "kubernetes_secret" "wildcard_gateways" {
  metadata {
    name      = "wildcard"
    namespace = kubernetes_namespace.istio_gateways.id
  }

  type = "kubernetes.io/tls"

  data = {
    "tls.crt" = aws_acmpca_certificate.wildcard.certificate,
    "tls.key" = file("/mnt/workspace/<pemfile>.pem"),
  }
}

resource "aws_secretsmanager_secret" "wildcard" {
  name = "wildcard-tls-cert"
}

resource "aws_secretsmanager_secret_version" "wildcard" {
  secret_id = aws_secretsmanager_secret.wildcard.id
  secret_string = jsonencode({
    "tls.crt" = aws_acmpca_certificate.wildcard.certificate,
    "tls.key" = file("/mnt/workspace/<pemfile>.pem"),
    "ca.crt"  = data.aws_acmpca_certificate_authority.root.certificate,
  })
}
