resource "helm_release" "csi" {
  count       = var.is_enabled ? 1:0

  name        = local.csi.name
  repository  = var.helm.repository
  chart       = var.helm.chart
  namespace   = var.helm.namespace

  set {
    name = "controller.serviceAccount.name"
    value = local.csi.service_account_name
  }

  set {
    name  = "controller.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.csi-role.arn
  }

  dynamic "set" {
    for_each = local.csi.tolerations.general
    content {
      name  = "node.tolerations[0].${set.key}"
      value = set.value
    }
  }

  dynamic "set" {
    for_each = local.csi.tolerations.observability
    content {
      name  = "node.tolerations[0].${set.key}"
      value = set.value
    }
  }

  dynamic "set" {
    for_each = local.csi.tolerations.gpu
    content {
      name  = "node.tolerations[0].${set.key}"
      value = set.value
    }
  }

  depends_on = [
    aws_iam_role.csi-role
  ]
}