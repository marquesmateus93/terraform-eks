resource "helm_release" "cluster-autoscaler" {
  count       = var.is_enabled ? 1:0

  name        = local.cluster-autoscaler.name
  repository  = var.helm.repository
  chart       = var.helm.chart
  namespace   = var.helm.namespace

  set {
    name  = "rbac.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.cluster-autoscaler-role.arn
  }

  set {
    name  = "rbac.serviceAccount.name"
    value = local.cluster-autoscaler-role.service_account_name
  }

  set {
    name  = "awsRegion"
    value = data.aws_region.current_region.name
  }

  set {
    name  = "autoDiscovery.clusterName"
    value = var.cluster_name
  }

  depends_on = [
    aws_iam_role.cluster-autoscaler-role
  ]
}