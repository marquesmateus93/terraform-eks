resource "helm_release" "iaris-csi-helm" {
  count       = var.is_enabled ? 1:0

  name        = local.iaris-csi-helm.name
  repository  = var.helm.repository
  chart       = var.helm.chart
  namespace   = var.helm.namespace

  set {
    name = "controller.serviceAccount.name"
    value = local.iaris-csi-helm.service_account_name
  }

  set {
    name  = "controller.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.iaris-csi-role.arn
  }

  dynamic "set" {
    for_each = local.iaris-csi-helm.tolerations.gpu
    content {
      name  = "node.tolerations[0].${set.key}"
      value = set.value
    }
  }

  dynamic "set" {
    for_each = local.iaris-csi-helm.tolerations.behaviour_audio
    content {
      name  = "node.tolerations[1].${set.key}"
      value = set.value
    }
  }

  dynamic "set" {
    for_each = local.iaris-csi-helm.tolerations.behaviour_video
    content {
      name  = "node.tolerations[2].${set.key}"
      value = set.value
    }
  }

  dynamic "set" {
    for_each = local.iaris-csi-helm.tolerations.gpu
    content {
      name  = "controller.tolerations[0].${set.key}"
      value = set.value
    }
  }

  dynamic "set" {
    for_each = local.iaris-csi-helm.tolerations.behaviour_audio
    content {
      name  = "controller.tolerations[1].${set.key}"
      value = set.value
    }
  }

  dynamic "set" {
    for_each = local.iaris-csi-helm.tolerations.behaviour_video
    content {
      name  = "controller.tolerations[2].${set.key}"
      value = set.value
    }
  }

  depends_on = [
    aws_iam_role.iaris-csi-role
  ]
}