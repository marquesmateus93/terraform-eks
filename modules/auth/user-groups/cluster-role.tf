resource "kubernetes_cluster_role_v1" "eks-cluster-role" {
  count = length(local.cluster_role)

  metadata {
    name = local.cluster_role[count.index].name
  }

  rule {
    api_groups  = local.cluster_role[count.index].rule[0].apiGroups
    resources   = local.cluster_role[count.index].rule[0].resources
    verbs       = local.cluster_role[count.index].rule[0].verbs
  }

  # depends_on = [
  #   kubernetes_config_map_v1_data.eks-auth-configmap
  # ]
}