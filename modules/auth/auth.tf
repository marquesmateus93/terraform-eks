resource "kubernetes_config_map_v1_data" "iaris-eks-auth-configmap" {
  metadata {
    name      = local.iaris-eks-auth-configmap.name
    namespace = local.iaris-eks-auth-configmap.namespace
  }

  data = {
    mapRoles = yamlencode(
      local.iaris-eks-auth-configmap.default_map_roles
    )
  }

  force = local.iaris-eks-auth-configmap.force
}