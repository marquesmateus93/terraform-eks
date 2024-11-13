resource "helm_release" "csi-secrets-store" {
  count       = var.is_enabled ? 1:0

  name        = local.csi-secrets-store.name
  repository  = var.helm.repository
  chart       = var.helm.chart
  namespace   = var.helm.namespace

  set {
    name  = "syncSecret.enabled"
    value = "true"
  }

  dynamic "set" {
    for_each = local.csi-secrets-store.tolerations.general
    content {
      name  = "linux.tolerations[0].${set.key}"
      value = set.value
    }
  }

  dynamic "set" {
    for_each = local.csi-secrets-store.tolerations.observability
    content {
      name  = "linux.tolerations[0].${set.key}"
      value = set.value
    }
  }

  dynamic "set" {
    for_each = local.csi-secrets-store.tolerations.gpu
    content {
      name  = "linux.tolerations[0].${set.key}"
      value = set.value
    }
  }
}