resource "helm_release" "csi" {
  name        = local.helm_name
  repository  = var.helm.repository
  chart       = var.helm.chart
  namespace   = var.helm.namespace

  set {
    name  = "controller.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.csi.arn
  }
}