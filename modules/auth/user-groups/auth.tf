resource "kubernetes_config_map_v1_data" "eks-auth-cfm" {
  metadata {
    name      = local.eks-auth-cfm.name
    namespace = local.eks-auth-cfm.namespace
  }

  data = {
    mapRoles = yamlencode(
      concat(
        local.eks-auth-cfm.default_map_roles,
        var.custom_map_rules
      )
    )
  }

  force = local.eks-auth-cfm.force
}