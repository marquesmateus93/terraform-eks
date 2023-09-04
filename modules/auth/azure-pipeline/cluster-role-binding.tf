resource "kubernetes_cluster_role_binding_v1" "iaris-azure-pipeline-cluster-role-binding" {
  count = length(local.iaris_namespace.namespace)

  metadata {
    name = local.iaris-azure-pipeline-cluster-role-binding[0].name
  }

  subject {
    kind      = local.iaris-azure-pipeline-cluster-role-binding[0].subjects[0].kind
    name      = local.iaris-azure-pipeline-cluster-role-binding[0].subjects[0].name
    namespace = local.iaris_namespace.namespace[count.index]
  }

  role_ref {
    kind      = local.iaris-azure-pipeline-cluster-role-binding[0].roleRef[0].kind
    name      = local.iaris-azure-pipeline-cluster-role-binding[0].roleRef[0].name
    api_group = local.iaris-azure-pipeline-cluster-role-binding[0].roleRef[0].apiGroup
  }

  depends_on = [
    kubernetes_cluster_role_v1.iaris-azure-pipeline-cluster-role
  ]
}