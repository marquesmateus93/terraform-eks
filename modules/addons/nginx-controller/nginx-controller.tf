resource "helm_release" "nginx-controller" {
  count       = var.is_enabled ? 1:0

  name        = local.nginx-controller.name
  repository  = var.helm.repository
  chart       = var.helm.chart
  namespace   = var.helm.namespace

  dynamic "set" {
    for_each = local.nginx-controller.tolerations.general
    content {
      name  = "controller.tolerations[0].${set.key}"
      value = set.value
    }
  }

  dynamic "set" {
    for_each = local.nginx-controller.tolerations.observability
    content {
      name  = "controller.tolerations[1].${set.key}"
      value = set.value
    }
  }

  dynamic "set" {
    for_each = local.nginx-controller.tolerations.gpu
    content {
      name  = "controller.tolerations[1].${set.key}"
      value = set.value
    }
  }
}