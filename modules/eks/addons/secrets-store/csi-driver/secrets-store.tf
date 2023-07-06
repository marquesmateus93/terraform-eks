resource "helm_release" "csi-secrets-store" {
  name        = local.helm_name
  repository  = var.helm.repository
  chart       = var.helm.chart
  namespace   = var.helm.namespace
}