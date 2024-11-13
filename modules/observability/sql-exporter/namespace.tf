resource "kubernetes_namespace_v1" "sql-exporter" {
    count = var.is_enabled ? 1:0

    metadata {
        name = local.sql-exporter-deployment.metadata.namespace
    }
}