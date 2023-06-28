resource "helm_release" "alb-controller" {
  name        = local.helm_name
  repository  = var.helm.repository
  chart       = var.helm.chart
  namespace   = var.assume_role_policy.namespace

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.alb-controller.arn
  }

  set {
    name  = "clusterName"
    value = var.cluster_name
  }

  set {
    name  = "serviceAccount.name"
    value = var.assume_role_policy.serviceAccountName
  }
}