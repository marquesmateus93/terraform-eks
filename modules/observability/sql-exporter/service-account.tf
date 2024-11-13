resource "kubernetes_service_account_v1" "sql-exporter-service-account" {
    count    = var.is_enabled ? 1:0

    metadata {
        name      = local.sql-exporter-deployment.serviceaccount.name
        namespace = local.sql-exporter-deployment.metadata.namespace
        annotations =  {
            "eks.amazonaws.com/role-arn" = aws_iam_role.sql-exporter-role[count.index].arn
        }
    }
}