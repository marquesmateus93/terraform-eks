resource "helm_release" "iaris-keda-helm" {
  count             = var.is_enabled ? 1:0

  name              = local.iaris-keda-helm.name
  repository        = var.helm.repository
  chart             = var.helm.chart
  namespace         = var.helm.namespace
  create_namespace  = local.iaris-keda-helm.create_namespace
}