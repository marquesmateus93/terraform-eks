resource "helm_release" "secrets-store" {
  name        = local.helm_name
  repository  = var.helm.repository
  chart       = var.helm.chart
  namespace   = var.helm.namespace
}