resource "kubernetes_namespace_v1" "iaris_namespace" {
  count = local.iaris_namespace.namespace[0] == "default" ? 0 : length(local.iaris_namespace.namespace)

  metadata {
    name = local.iaris_namespace.namespace[count.index]
  }
}