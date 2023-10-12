resource "helm_release" "iaris-nginx-controller" {
  count       = var.is_enabled ? 1:0

  name        = local.iaris-nginx-controller.name
  repository  = var.helm.repository
  chart       = var.helm.chart
  namespace   = var.helm.namespace

  dynamic "set" {
    for_each = local.iaris-nginx-controller.tolerations.gpu
    content {
      name  = "controller.tolerations[0].${set.key}"
      value = set.value
    }
  }

  dynamic "set" {
    for_each = local.iaris-nginx-controller.tolerations.behaviour_audio
    content {
      name  = "controller.tolerations[1].${set.key}"
      value = set.value
    }
  }

  dynamic "set" {
    for_each = local.iaris-nginx-controller.tolerations.behaviour_video
    content {
      name  = "controller.tolerations[2].${set.key}"
      value = set.value
    }
  }
}