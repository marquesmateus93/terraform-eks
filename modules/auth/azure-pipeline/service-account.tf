resource "kubernetes_service_account_v1" "iaris-azure-pipeline-service-account" {
  count = length(local.iaris_namespace.namespace)

  metadata {
    name      = local.iaris-azure-pipeline-service-account.name
    namespace = local.iaris_namespace.namespace[count.index]
  }
}

resource "kubernetes_secret_v1" "iaris-azure-pipeline-secret" {
  count = length(local.iaris_namespace.namespace)

  metadata {
    name        = local.iaris-azure-pipeline-secret.metadata.name
    namespace   = local.iaris_namespace.namespace[count.index]
    annotations = local.iaris-azure-pipeline-secret.metadata.annotations
  }

  type = local.iaris-azure-pipeline-secret.type

  depends_on = [
    kubernetes_service_account_v1.iaris-azure-pipeline-service-account
  ]
}