locals {
  iaris-eks-auth-configmap = {
    name        = var.aws_auth.name
    namespace   = var.aws_auth.namespace
    force       = var.aws_auth.force
    default_map_roles = [
      {
        groups   = [
          "system:bootstrappers",
          "system:nodes"
        ]
        rolearn     = var.node-groups.general
        username    = "system:node:{{EC2PrivateDNSName}}"
      },
      {
        groups   = [
          "system:bootstrappers",
          "system:nodes"
        ]
        rolearn     = var.node-groups.easyproctor-image
        username    = "system:node:{{EC2PrivateDNSName}}"
      },
      {
        groups   = [
          "administrator"
        ]
        rolearn     = data.aws_iam_role.iaris-administrator-role.arn
        username    = "administrator"
      }
    ]
  }

  cluster_role = [
    {
      name = "cluster-role-${local.iaris-eks-auth-configmap.default_map_roles[2].username}"
      rule = [
        {
          apiGroups   = ["*"]
          resources   = ["*"]
          verbs       = ["*"]
        }
      ]
    }
  ]

  cluster_role_binding = [
    {
      name = "cluster-role-binding-${local.iaris-eks-auth-configmap.default_map_roles[2].username}"
      subjects = [
        {
          kind        = "Group"
          name        = local.iaris-eks-auth-configmap.default_map_roles[2].username
          apiGroup    = "rbac.authorization.k8s.io"
        }
      ]
      roleRef = [
        {
          kind        = "ClusterRole"
          name        = local.cluster_role[0].name
          apiGroup    = "rbac.authorization.k8s.io"
        }
      ]
    }
  ]
}