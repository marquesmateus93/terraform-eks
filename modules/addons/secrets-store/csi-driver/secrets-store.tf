  resource "helm_release" "news-csi-secrets-store" {
  count       = var.is_enabled ? 1:0

  name        = local.news-csi-secrets-store.name
  repository  = var.helm.repository
  chart       = var.helm.chart
  namespace   = var.helm.namespace

  set {
    name  = "syncSecret.enabled"
    value = "true"
  }

  dynamic "set" {
    for_each = local.news-csi-secrets-store.tolerations.gpu
    content {
      name  = "linux.tolerations[0].${set.key}"
      value = set.value
    }
  }

  dynamic "set" {
    for_each = local.news-csi-secrets-store.tolerations.news_feed
    content {
      name  = "linux.tolerations[1].${set.key}"
      value = set.value
    }
  }

  dynamic "set" {
    for_each = local.news-csi-secrets-store.tolerations.news_system
    content {
      name  = "linux.tolerations[2].${set.key}"
      value = set.value
    }
  }
}