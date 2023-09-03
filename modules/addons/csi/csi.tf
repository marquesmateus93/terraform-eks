resource "helm_release" "iaris-csi-helm" {
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

  depends_on = [
    aws_iam_role.iaris-csi-role
  ]
}