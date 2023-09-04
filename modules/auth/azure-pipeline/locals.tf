locals {
  iaris-azure-pipeline-cluster-role = [
    {
      name = "${var.prefix_name}-azure-pipeline-cluster-role-${var.tags["environment"]}"
      rule = [
        {
          apiGroups   = ["*"]
          resources   = ["*"]
          verbs       = ["get", "watch", "list", "create"]
        }
      ]
    }
  ]

  iaris-azure-pipeline-cluster-role-binding = [
    {
      name = "${var.prefix_name}-azure-pipeline-cluster-role-binding-${var.tags["environment"]}"
      subjects = [
        {
          kind        = "ServiceAccount"
          name        = local.iaris-azure-pipeline-service-account.name
        }
      ]
      roleRef = [
        {
          kind        = "ClusterRole"
          name        = local.iaris-azure-pipeline-cluster-role[0].name
          apiGroup    = "rbac.authorization.k8s.io"
        }
      ]
    }
  ]

  iaris-azure-pipeline-service-account = {
    name = "${var.prefix_name}-azure-pipeline-service-account-${var.tags["environment"]}"
  }

  iaris-azure-pipeline-secret = {
    metadata = {
      name        = "${var.prefix_name}-azure-pipeline-secret-${var.tags["environment"]}"
      annotations = {
        "kubernetes.io/service-account.name" = local.iaris-azure-pipeline-service-account.name
      }
    }

    type = "kubernetes.io/service-account-token"
  }

  iaris_namespace = {
    namespace = length(var.namespaces) == 0 ? ["default"] : var.namespaces
  }
}