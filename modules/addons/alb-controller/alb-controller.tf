resource "helm_release" "alb-controller" {
  count       = var.is_enabled ? 1:0

  name        = local.alb-controller.name
  repository  = var.helm.repository
  chart       = var.helm.chart
  namespace   = var.helm.namespace

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.alb-controller-role.arn
  }

  set {
    name  = "clusterName"
    value = var.cluster_name
  }

  set {
    name  = "serviceAccount.name"
    value = local.alb-controller.service_account_name
  }

  depends_on = [
    aws_iam_role.alb-controller-role
  ]
}