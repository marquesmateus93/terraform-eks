resource "helm_release" "news-aws-secrets-store" {
  count       = var.is_enabled ? 1:0

  name        = local.news-aws-secrets-store.name
  repository  = var.helm.repository
  chart       = var.helm.chart
  namespace   = var.helm.namespace

  dynamic "set" {
    for_each = local.news-aws-secrets-store.tolerations.gpu
    content {
      name  = "tolerations[0].${set.key}"
      value = set.value
    }
  }

  dynamic "set" {
    for_each = local.news-aws-secrets-store.tolerations.news_feed
    content {
      name  = "tolerations[1].${set.key}"
      value = set.value
    }
  }

  dynamic "set" {
    for_each = local.news-aws-secrets-store.tolerations.news_system
    content {
      name  = "tolerations[2].${set.key}"
      value = set.value
    }
  }
}