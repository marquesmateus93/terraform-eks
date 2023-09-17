resource "helm_release" "iaris-aws-secrets-store" {
  count       = var.is_enabled ? 1:0

  name        = local.iaris-aws-secrets-store.name
  repository  = var.helm.repository
  chart       = var.helm.chart
  namespace   = var.helm.namespace

  dynamic "set" {
    for_each = local.iaris-aws-secrets-store.tolerations
    content {
      name  = "tolerations[${count.index}].${set.key}"
      value = set.value
    }
  }
}