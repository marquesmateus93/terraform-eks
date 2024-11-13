resource "helm_release" "keda" {
  count             = var.is_enabled ? 1:0

  name              = local.keda.name
  repository        = var.helm.repository
  chart             = var.helm.chart
  namespace         = var.helm.namespace
  create_namespace  = local.keda.create_namespace
}