resource "kubernetes_cluster_role_binding_v1" "eks-cluster-role-binding" {
  count = length(local.cluster_role_binding)

  metadata {
    name = local.cluster_role_binding[count.index].name
  }

  subject {
    kind      = local.cluster_role_binding[count.index].subjects[0].kind
    name      = local.cluster_role_binding[count.index].subjects[0].name
    api_group = local.cluster_role_binding[count.index].subjects[0].apiGroup
  }

  role_ref {
    kind      = local.cluster_role_binding[count.index].roleRef[0].kind
    name      = local.cluster_role_binding[count.index].roleRef[0].name
    api_group = local.cluster_role_binding[count.index].roleRef[0].apiGroup
  }

  depends_on = [
    kubernetes_cluster_role_v1.eks-cluster-role
  ]
}