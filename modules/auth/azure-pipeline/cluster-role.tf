resource "kubernetes_cluster_role_v1" "iaris-azure-pipeline-cluster-role" {
  metadata {
    name = local.iaris-azure-pipeline-cluster-role[0].name
  }

  rule {
    api_groups  = local.iaris-azure-pipeline-cluster-role[0].rule[0].apiGroups
    resources   = local.iaris-azure-pipeline-cluster-role[0].rule[0].resources
    verbs       = local.iaris-azure-pipeline-cluster-role[0].rule[0].verbs
  }

  depends_on = [
    kubernetes_service_account_v1.iaris-azure-pipeline-service-account
  ]
}