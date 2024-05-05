resource "helm_release" "news-keda-helm" {
  count             = var.is_enabled ? 1:0

  name              = local.news-keda-helm.name
  repository        = var.helm.repository
  chart             = var.helm.chart
  namespace         = var.helm.namespace
  create_namespace  = local.news-keda-helm.create_namespace
}