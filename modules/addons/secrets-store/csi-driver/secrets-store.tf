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

  dynamic "set" {
    for_each = local.iaris-csi-secrets-store.tolerations.gpu
    content {
      name  = "linux.tolerations[${count.index}].${set.key}"
      value = set.value
    }
  }

  dynamic "set" {
    for_each = local.iaris-csi-secrets-store.tolerations.behaviour_audio
    content {
      name  = "linux.tolerations[${count.index}].${set.key}"
      value = set.value
    }
  }

  dynamic "set" {
    for_each = local.iaris-csi-secrets-store.tolerations.behaviour_video
    content {
      name  = "linux.tolerations[${count.index}].${set.key}"
      value = set.value
    }
  }
}