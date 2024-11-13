resource "helm_release" "service-monitors" {
  count       = var.is_enabled ? 1:0

  name        = local.service-monitors.name
  repository  = var.helm.service_monitors.repository
  chart       = var.helm.service_monitors.chart
}

resource "helm_release" "metagpu" {
  count             = var.is_enabled ? 1:0

  name              = local.metagpu.name
  repository        = var.helm.metagpu.repository
  chart             = var.helm.metagpu.chart
  namespace         = var.helm.metagpu.namespace
  create_namespace  = local.metagpu.create_namespace

  set {
    name  = "driver.namespace"
    value = var.helm.metagpu.namespace
  }

  depends_on = [
    helm_release.service-monitors
  ]
}