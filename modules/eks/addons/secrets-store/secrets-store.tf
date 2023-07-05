resource "helm_release" "secrets-store" {
  name        = local.helm_name
  repository  = var.helm.repository
  chart       = var.helm.chart
  namespace   = var.helm.namespace

  set {
    name  = "image.tag"
    value = "1.0.r2-46-gf2a8f35-2023.03.21.21.55"
  }

  set {
    name  = "grpcSupportedProviders"
    value = "aws"
  }
}