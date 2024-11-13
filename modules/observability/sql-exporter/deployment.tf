resource "kubernetes_deployment_v1" "sql-exporter-deployment" {
  count = var.is_enabled ? 1:0

  metadata {
    name      = local.sql-exporter-deployment.metadata.name
    namespace = local.sql-exporter-deployment.metadata.namespace
  }

  spec {
    replicas = local.sql-exporter-deployment.replicas

    strategy {
      rolling_update {
        max_surge       = local.sql-exporter-deployment.rollingupdate.rollingupdate_maxsurge
        max_unavailable = local.sql-exporter-deployment.rollingupdate.rollingupdate_maxunavailable
      }
    }

    selector {
        match_labels = local.sql-exporter-deployment.labels
    }

    template {
      metadata {
        labels      = local.sql-exporter-deployment.labels
        annotations = local.sql-exporter-deployment.annotations
      }

      spec {
        service_account_name = local.sql-exporter-deployment.serviceaccount.name
        
        container {
          name  = local.sql-exporter-deployment.containers.name
          image = local.sql-exporter-deployment.containers.image
          
          port {
            name           = local.sql-exporter-deployment.containers.port.name
            container_port = local.sql-exporter-deployment.containers.port.container_port
          }
          
          env {
            name  = "CONFIG"
            value = "/config/config.yml"
          }

          env {
            name  = "MSSQL_HOST"
            value = data.aws_db_instance.rds-instance[count.index].endpoint
          }

          env {
            name  = "MSSQL_BASE_NAME"
            value = var.rds.base_name
          }

          env {
            name  = "MSSQL_USER"
            value_from {
              secret_key_ref {
                name  = local.secret-provider-class.secret_name
                key   = "MSSQL_USER"
              }
            }
          }

          env {
            name  = "MSSQL_PASSWORD"
            value_from {
              secret_key_ref {
                name  = local.secret-provider-class.secret_name
                key   = "MSSQL_PASSWORD"
              }
            }
          }

          liveness_probe {
            http_get {
              path = local.sql-exporter-deployment.liveness_probe.http_get.path
              port = local.sql-exporter-deployment.liveness_probe.http_get.port
            }
            initial_delay_seconds = local.sql-exporter-deployment.liveness_probe.initial_delay_seconds
            timeout_seconds       = local.sql-exporter-deployment.liveness_probe.timeout_seconds
          }

          readiness_probe {
            http_get {
              path = local.sql-exporter-deployment.readiness_probe.http_get.path
              port = local.sql-exporter-deployment.readiness_probe.http_get.port
            }
            initial_delay_seconds = local.sql-exporter-deployment.readiness_probe.initial_delay_seconds
            timeout_seconds       = local.sql-exporter-deployment.readiness_probe.timeout_seconds
          }

          resources {
            limits = {
              cpu     = local.sql-exporter-deployment.resources.limits.cpu
              memory  = local.sql-exporter-deployment.resources.limits.memory
            }
            requests = {
              cpu     = local.sql-exporter-deployment.resources.requests.cpu
              memory  = local.sql-exporter-deployment.resources.requests.memory
            }
          }
          volume_mount {
            name        = local.sql-exporter-deployment.volume_csi.name
            mount_path  = local.sql-exporter-deployment.volume_mount.csi.mount_path
          }
          volume_mount {
            name        = local.sql-exporter-deployment.volume_configmap.name
            mount_path  = "${local.sql-exporter-deployment.volume_mount.configmap.mount_path}/config.yml"
            sub_path    = "config.yml"
          }
        }
        volume {
          name = local.sql-exporter-deployment.volume_csi.name
          csi {
            driver    = local.sql-exporter-deployment.volume_csi.csi.driver
            read_only = local.sql-exporter-deployment.volume_csi.csi.read_only
            volume_attributes = {
              "secretProviderClass" = resource.kubernetes_manifest.secret-provider-class[count.index].manifest.metadata.name
            }
          }
        }
        volume {
          name = local.sql-exporter-deployment.volume_configmap.name
          config_map {
            name = local.sql-exporter-configmap.name
          }
        }
      }
    }
  }
}