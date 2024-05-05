resource "helm_release" "news-nginx-controller" {
  count       = var.is_enabled ? 1:0

  name        = local.news-nginx-controller.name
  repository  = var.helm.repository
  chart       = var.helm.chart
  namespace   = var.helm.namespace

  dynamic "set" {
    for_each = local.news-nginx-controller.tolerations.gpu
    content {
      name  = "controller.tolerations[0].${set.key}"
      value = set.value
    }
  }

  dynamic "set" {
    for_each = local.news-nginx-controller.tolerations.news_feed
    content {
      name  = "controller.tolerations[1].${set.key}"
      value = set.value
    }
  }

  dynamic "set" {
    for_each = local.news-nginx-controller.tolerations.news_system
    content {
      name  = "controller.tolerations[2].${set.key}"
      value = set.value
    }
  }
}