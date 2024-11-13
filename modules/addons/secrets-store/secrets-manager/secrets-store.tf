resource "helm_release" "aws-secrets-store" {
  count       = var.is_enabled ? 1:0

  name        = local.aws-secrets-store.name
  repository  = var.helm.repository
  chart       = var.helm.chart
  namespace   = var.helm.namespace

  dynamic "set" {
    for_each = local.aws-secrets-store.tolerations.general
    content {
      name  = "tolerations[0].${set.key}"
      value = set.value
    }
  }

  dynamic "set" {
    for_each = local.aws-secrets-store.tolerations.observability
    content {
      name  = "tolerations[0].${set.key}"
      value = set.value
    }
  }

  dynamic "set" {
    for_each = local.aws-secrets-store.tolerations.gpu
    content {
      name  = "tolerations[0].${set.key}"
      value = set.value
    }
  }
}