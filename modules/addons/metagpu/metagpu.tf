resource "helm_release" "iaris-service-monitors" {
  name        = local.iaris-service-monitors.name
  repository  = var.helm_iaris_service_monitors.repository
  chart       = var.helm_iaris_service_monitors.chart
}

resource "helm_release" "iaris-metagpu" {
  name              = local.iaris-metagpu.name
  repository        = var.helm_iaris_metagpu.repository
  chart             = var.helm_iaris_metagpu.chart
  namespace         = var.helm_iaris_metagpu.namespace
  create_namespace  = local.iaris-metagpu.create_namespace

  depends_on = [
    helm_release.iaris-service-monitors
  ]
}