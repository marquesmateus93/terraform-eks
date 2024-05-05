resource "helm_release" "news-service-monitors" {
  count       = var.is_enabled ? 1:0

  name        = local.news-service-monitors.name
  repository  = var.helm_service_monitors.repository
  chart       = var.helm_service_monitors.chart
}

resource "helm_release" "news-metagpu" {
  count             = var.is_enabled ? 1:0

  name              = local.news-metagpu.name
  repository        = var.helm_metagpu.repository
  chart             = var.helm_metagpu.chart
  namespace         = var.helm_metagpu.namespace
  create_namespace  = local.news-metagpu.create_namespace

  set {
    name  = "driver.namespace"
    value = var.helm_metagpu.namespace
  }

  depends_on = [
    helm_release.news-service-monitors
  ]
}