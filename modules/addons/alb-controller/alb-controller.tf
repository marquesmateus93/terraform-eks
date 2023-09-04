resource "helm_release" "iaris-alb-controller-helm" {
  count       = var.is_enabled ? 1:0

  name        = local.iaris-alb-controller-helm.name
  repository  = var.helm.repository
  chart       = var.helm.chart
  namespace   = var.helm.namespace

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.iaris-alb-controller-role.arn
  }

  set {
    name  = "clusterName"
    value = var.cluster_name
  }

  set {
    name  = "serviceAccount.name"
    value = local.iaris-alb-controller-helm.service_account_name
  }

  depends_on = [
    aws_iam_role.iaris-alb-controller-role
  ]
}