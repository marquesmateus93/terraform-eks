resource "helm_release" "cloudwatch-metrics" {
  count             = var.is_enabled ? 1:0
  
  name              = local.cloudwatch-metrics.name
  repository        = var.helm.repository
  chart             = var.helm.chart
  namespace         = var.helm.namespace
  create_namespace  = local.cloudwatch-metrics.create_namespace
  recreate_pods     = local.cloudwatch-metrics.recreate_pods

  set {
    name  = "clusterName"
    value = var.cluster_name
  }

  set {
    name  = "statsd.cloudwatch_namespace"
    value = var.helm.namespace
  }

  set {
    name  = "serviceAccount.name"
    value = local.cloudwatch-metrics.service_account_name
  }

  dynamic "set" {
    for_each = local.cloudwatch-metrics.tolerations.general
    content {
      name  = "tolerations[0].${set.key}"
      value = set.value
    }
  }

  dynamic "set" {
    for_each = local.cloudwatch-metrics.tolerations.observability
    content {
      name  = "tolerations[1].${set.key}"
      value = set.value
    }
  }

  dynamic "set" {
    for_each = local.cloudwatch-metrics.tolerations.gpu
    content {
      name  = "tolerations[2].${set.key}"
      value = set.value
    }
  }
}