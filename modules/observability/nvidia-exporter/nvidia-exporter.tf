resource "helm_release" "prometheus-operator-crds" {
    count             = var.is_enabled ? 1:0

    name              = local.prometheus-operator-crds.name
    repository        = var.helm.prometheus-operator-crds.repository
    chart             = var.helm.prometheus-operator-crds.chart
    recreate_pods     = local.nvidia-exporter.recreate_pods
    namespace         = var.helm.prometheus-operator-crds.namespace
    create_namespace  = local.prometheus-operator-crds.create_namespace
}

resource "helm_release" "nvidia-exporter" {
    count             = var.is_enabled ? 1:0

    name              = local.nvidia-exporter.name
    repository        = var.helm.nvidia-exporter.repository
    chart             = var.helm.nvidia-exporter.chart
    recreate_pods     = local.nvidia-exporter.recreate_pods
    namespace         = var.helm.nvidia-exporter.namespace
    create_namespace  = local.nvidia-exporter.create_namespace

    dynamic "set" {
        for_each = local.nvidia-exporter.tolerations.nvidia
        content {
            name  = "tolerations[0].${set.key}"
            value = set.value
        }
    }

    set {
        name    = "namespaceOverride"
        value   = var.helm.nvidia-exporter.namespace
    }

    set {
        name  = "nodeSelector.accelerator"
        value = local.nvidia-exporter.node-selector.name
    }

    set {
        name  = "podAnnotations.prometheus\\.io/scrape"
        value = local.nvidia-exporter.prometheus-annotations.scrape
        type = "string"
    }

    set {
        name  = "podAnnotations.prometheus\\.io/port"
        value = local.nvidia-exporter.prometheus-annotations.port
        type = "string"
    }

    depends_on = [
        helm_release.prometheus-operator-crds
    ]
}