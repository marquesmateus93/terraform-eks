resource "kubernetes_config_map_v1" "sql-exporter-configmap" {
    count = var.is_enabled ? 1:0

    metadata {
        name        = local.sql-exporter-configmap.name
        namespace   = var.deployment.namespace
    }
    data = var.configmap_job_query
}