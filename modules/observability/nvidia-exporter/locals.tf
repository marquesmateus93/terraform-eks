locals {
    nvidia-exporter = {
        name              = lower("${var.prefix_name}-nvidia-exporter-${var.tags["environment"]}")
        recreate_pods     = true
        create_namespace  = true

        tolerations = {
            nvidia = {
                key      = "gpu",
                operator = "Exists",
                effect   = "NoSchedule"
            }
        }

        node-selector = {
            name = "nvidia"
        }

        prometheus-annotations = {
            scrape  = "true"
            port    = "9400"
        }
    }

    prometheus-operator-crds = {
        name              = lower("${var.prefix_name}-prometheus-operator-crds-${var.tags["environment"]}")
        recreate_pods     = true
        create_namespace  = true
    }
}