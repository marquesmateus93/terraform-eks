resource "helm_release" "iaris-aws-secrets-store" {
  count       = var.is_enabled ? 1:0

  name        = local.iaris-aws-secrets-store.name
  repository  = var.helm.repository
  chart       = var.helm.chart
  namespace   = var.helm.namespace

  dynamic "set" {
    for_each = local.iaris-aws-secrets-store.tolerations.gpu
    content {
      name  = "tolerations[0].${set.key}"
      value = set.value
    }
  }

  dynamic "set" {
    for_each = local.iaris-aws-secrets-store.tolerations.behaviour_audio
    content {
      name  = "tolerations[1].${set.key}"
      value = set.value
    }
  }

  dynamic "set" {
    for_each = local.iaris-aws-secrets-store.tolerations.behaviour_video
    content {
      name  = "tolerations[2].${set.key}"
      value = set.value
    }
  }
}