resource "helm_release" "iaris-csi-secrets-store" {
  count       = var.is_enabled ? 1:0

  name        = local.iaris-csi-secrets-store.name
  repository  = var.helm.repository
  chart       = var.helm.chart
  namespace   = var.helm.namespace

  set {
    name  = "syncSecret.enabled"
    value = "true"
  }
}