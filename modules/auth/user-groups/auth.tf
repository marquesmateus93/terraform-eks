resource "kubernetes_config_map_v1_data" "news-eks-auth-configmap" {
  metadata {
    name      = local.news-eks-auth-configmap.name
    namespace = local.news-eks-auth-configmap.namespace
  }

  data = {
    mapRoles = yamlencode(
      concat(
        local.news-eks-auth-configmap.default_map_roles,
        var.custom_map_rules
      )
    )
  }

  force = local.news-eks-auth-configmap.force
}