resource "helm_release" "secrets-store" {
  name        = local.helm_name
  repository  = var.helm.repository
  chart       = var.helm.chart
  namespace   = var.helm.namespace

  set {
    name  = "image.tag"
    value = "1.0.r2-50-g5b4aca1-2023.06.09.21.19"
  }

  set {
    name  = "grpcSupportedProviders"
    value = "aws"
  }
}