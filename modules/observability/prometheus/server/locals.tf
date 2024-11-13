locals {
    prometheus-helm = {
        name              = lower("${var.prefix_name}-prometheus-${var.tags["environment"]}")
        recreate_pods     = true
        create_namespace  = true

        remote_write = {
            queue_config = {
                max_samples_per_send    = "1000"
                max_shards              = "200"
                capacity                = "2500"
            }
        }

        tolerations = {
            observability = {
                key      = "observability",
                operator = "Equal",
                value    = "present",
                effect   = "NoSchedule"
            }
        }

        alertmanager = {
            enabled = var.components.alertmanager
        }

        kube-state-metrics = {
            enabled = var.components.kube-state-metrics
        }

        prometheus-pushgateway = {
            enabled = var.components.prometheus-pushgateway
        }
    }

    internal-ingress = {
        metadata = {
            name        = lower("${var.prefix_name}-prometheus-ing-${var.tags["environment"]}")
            annotations = {
                load-balancer-name  = lower("${var.prefix_name}-prometheus-alb-${var.tags["environment"]}")
                listen-ports        = "[{\"HTTP\": 80}, {\"HTTPS\": 443}]"
                target-type         = var.internal-ingress.target-type
                scheme              = var.internal-ingress.scheme
                ip-address-type     = var.internal-ingress.ip-address-type
            }
        }
    }

    prometheus-role = {
        name                  = "${var.prefix_name}-prometheus-role-${var.tags["environment"]}"
        service_account_name  = "${var.prefix_name}-prometheus-sa-${var.tags["environment"]}"
    }

    prometheus-policy = {
        name    = "${var.prefix_name}-prometheus-policy-${var.tags["environment"]}"
    }
}