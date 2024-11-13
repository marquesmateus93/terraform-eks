resource "helm_release" "prometheus" {
    count             = var.is_enabled ? 1:0

    name              = local.prometheus-helm.name
    repository        = var.helm.repository
    chart             = var.helm.chart
    recreate_pods     = local.prometheus-helm.recreate_pods
    namespace         = var.helm.namespace
    create_namespace  = local.prometheus-helm.create_namespace

    set {
        name  = "server.fullnameOverride"
        value = local.prometheus-helm.name
    }

    set {
        name  = "awsRegion"
        value = data.aws_region.current_region.name
    }

    set {
        name  = "autoDiscovery.clusterName"
        value = var.cluster_name
    }

    set {
        name  = "alertmanager.enabled"
        value = local.prometheus-helm.alertmanager.enabled
    }

    set {
        name  = "kube-state-metrics.enabled"
        value = local.prometheus-helm.kube-state-metrics.enabled
    }

    set {
        name  = "prometheus-pushgateway.enabled"
        value = local.prometheus-helm.prometheus-pushgateway.enabled
    }

    dynamic "set" {
        for_each = local.prometheus-helm.tolerations.observability
        content {
            name  = "server.tolerations[0].${set.key}"
            value = set.value
        }
    }
}