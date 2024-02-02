resource "kubernetes_namespace" "istio_system" {
  metadata {
    name = "istio-system"
    labels = {
      "policy.sigstore.dev/exclude" : "true"
    }
  }

  depends_on = [module.eks]
}

resource "helm_release" "istio" {
  name       = "tetrate-istio"
  repository = "https://tetratelabs.github.io/istio-helm"
  chart      = "tetrate-fips"
  version    = "1.15.1"

  namespace = kubernetes_namespace.istio_system.metadata[0].name

  values = [
    file("${path.module}/manifests/<manifest>.yaml"),
  ]

  depends_on = [
    kubernetes_namespace.istio_system,
  ]
}
