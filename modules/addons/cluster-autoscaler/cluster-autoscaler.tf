resource "helm_release" "iaris-cluster-autoscaler" {
  name        = local.iaris-cluster-autoscaler-helm.name
  repository  = var.helm.repository
  chart       = var.helm.chart
  namespace   = var.helm.namespace

  set {
    name  = "rbac.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.iaris-cluster-autoscaler-role.arn
  }

  set {
    name  = "rbac.serviceAccount.name"
    value = local.iaris-cluster-autoscaler-role.service_account_name
  }

  set {
    name  = "awsRegion"
    value = data.aws_region.iaris_current_region.name
  }

  set {
    name  = "autoDiscovery.clusterName"
    value = var.cluster_name
  }

  depends_on = [
    aws_iam_role.iaris-cluster-autoscaler-role
  ]
}