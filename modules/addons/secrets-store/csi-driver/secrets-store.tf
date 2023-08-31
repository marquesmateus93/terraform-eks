resource "helm_release" "iaris-csi-secrets-store" {
  name        = local.iaris-csi-secrets-store.name
  repository  = var.helm.repository
  chart       = var.helm.chart
  namespace   = var.helm.namespace
}