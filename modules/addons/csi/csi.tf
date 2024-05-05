resource "helm_release" "news-csi-helm" {
  count       = var.is_enabled ? 1:0

  name        = local.news-csi-helm.name
  repository  = var.helm.repository
  chart       = var.helm.chart
  namespace   = var.helm.namespace

  set {
    name = "controller.serviceAccount.name"
    value = local.news-csi-helm.service_account_name
  }

  set {
    name  = "controller.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.news-csi-role.arn
  }

  dynamic "set" {
    for_each = local.news-csi-helm.tolerations.gpu
    content {
      name  = "node.tolerations[0].${set.key}"
      value = set.value
    }
  }

  dynamic "set" {
    for_each = local.news-csi-helm.tolerations.news_feed
    content {
      name  = "node.tolerations[1].${set.key}"
      value = set.value
    }
  }

  dynamic "set" {
    for_each = local.news-csi-helm.tolerations.news_system
    content {
      name  = "node.tolerations[2].${set.key}"
      value = set.value
    }
  }

  dynamic "set" {
    for_each = local.news-csi-helm.tolerations.gpu
    content {
      name  = "controller.tolerations[0].${set.key}"
      value = set.value
    }
  }

  dynamic "set" {
    for_each = local.news-csi-helm.tolerations.news_feed
    content {
      name  = "controller.tolerations[1].${set.key}"
      value = set.value
    }
  }

  dynamic "set" {
    for_each = local.news-csi-helm.tolerations.news_system
    content {
      name  = "controller.tolerations[2].${set.key}"
      value = set.value
    }
  }

  depends_on = [
    aws_iam_role.news-csi-role
  ]
}