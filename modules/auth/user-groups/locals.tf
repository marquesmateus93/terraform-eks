locals {
  news-eks-auth-configmap = {
    name        = var.aws_auth.name
    namespace   = var.aws_auth.namespace
    force       = var.aws_auth.force
    default_map_roles = [
      {
        groups   = [
          "administrator"
        ]
        rolearn     = data.aws_iam_role.news-administrator-role.arn
        username    = "administrator"
      },
      {
        groups   = [
          "administrator-sso"
        ]
        rolearn     = tostring(tolist(data.aws_iam_roles.news-administrator-sso-role.arns)[0])
        username    = "administrator-sso"
      }
    ]
  }

  cluster_role = [
    {
      name = "cluster-role-${local.news-eks-auth-configmap.default_map_roles[0].username}"
      rule = [
        {
          apiGroups   = ["*"]
          resources   = ["*"]
          verbs       = ["*"]
        }
      ]
    },
    {
      name = "cluster-role-${local.news-eks-auth-configmap.default_map_roles[1].username}"
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
      name = "cluster-role-binding-${local.news-eks-auth-configmap.default_map_roles[0].username}"
      subjects = [
        {
          kind        = "Group"
          name        = local.news-eks-auth-configmap.default_map_roles[0].username
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
    },
    {
      name = "cluster-role-binding-${local.news-eks-auth-configmap.default_map_roles[1].username}"
      subjects = [
        {
          kind        = "Group"
          name        = local.news-eks-auth-configmap.default_map_roles[1].username
          apiGroup    = "rbac.authorization.k8s.io"
        }
      ]
      roleRef = [
        {
          kind        = "ClusterRole"
          name        = local.cluster_role[1].name
          apiGroup    = "rbac.authorization.k8s.io"
        }
      ]
    }
  ]
}