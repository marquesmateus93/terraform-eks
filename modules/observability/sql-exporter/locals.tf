locals {
    sql-exporter-deployment = {
        metadata = {
            name      = lower("${var.prefix_name}-sql-exporter-${var.tags["environment"]}")
            namespace = var.deployment.namespace
        }

        replicas = var.deployment.replicas

        rollingupdate = {
            rollingupdate_maxsurge          = var.deployment.rollingupdate_maxsurge
            rollingupdate_maxunavailable    = var.deployment.rollingupdate_maxunavailable
        }

        labels = {
            app = lower("${var.prefix_name}-sql-exporter-${var.tags["environment"]}")
        }

        annotations = {
            "prometheus.io/port"      = "9237"
            "prometheus.io/scrape"    = "true"  
            "prometheus.io/path"      = "/metrics"
        }

        serviceaccount = {
            name = "${var.prefix_name}-sql-exporter-serviceaccount"
        }

        containers = {
            name    = lower("${var.prefix_name}-sql-exporter-container")
            image   = var.deployment.image
            port = {
                name            = "metrics"
                container_port  = var.deployment.port
            }
        }

        liveness_probe = {
            http_get = {
                path = "/healthz"
                port = var.deployment.port
            }
            initial_delay_seconds = "10"
            timeout_seconds      = "10"
        }

        readiness_probe = {
            http_get = {
                path = "/healthz"
                port = var.deployment.port
            }
            initial_delay_seconds = "10"
            timeout_seconds       = "10"
        }

        resources = {
            limits = {
                cpu     = "250m"
                memory  = "32Mi"
            }
            requests = {
                cpu     = "5m"
                memory  = "16Mi"
            }
        }

        volume_mount = {
            csi = {
                mount_path = "/secret"
            }
            configmap = {
                mount_path = "/config"
            }
        }

        volume_csi = {
            name = lower("${var.prefix_name}-sql-exporter-secret-provider-volume")
            csi = {
                driver    = "secrets-store.csi.k8s.io"
                read_only = "true"
            }
        }

        volume_configmap = {
            name = lower("${var.prefix_name}-sql-exporter-configmap-volume")
        }
    }

    sql-exporter-configmap = {
        name = lower("${var.prefix_name}-sql-exporter-configmap")
    }

    sql-exporter-role = {
        name                      = "${var.prefix_name}-sql-exporter-role"
        oidc_eks_without_protocol = tostring(element(split("https://", data.tls_certificate.certificate.url), 1))
    }

    sql-exporter-policy = {
        name    = "${var.prefix_name}-sql-exporter-policy"
    }

    secret-provider-class = {
        name        = lower("${var.prefix_name}-sql-exporter-secret-provider-class")
        secret_name = lower("${var.prefix_name}-sql-exporter-secret")
    }
}