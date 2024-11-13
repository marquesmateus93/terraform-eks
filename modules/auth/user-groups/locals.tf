locals {
  eks-auth-cfm = {
    name        = var.aws_auth.name
    namespace   = var.aws_auth.namespace
    force       = var.aws_auth.force
    default_map_roles = [
      # { #0
      #   groups   = [
      #     "administrator"
      #   ]
      #   rolearn     = data.aws_iam_role.administrator-role.arn
      #   username    = "administrator"
      # },
      { #1
        groups   = [
          "administrator"
        ]
        rolearn     = replace(tolist(data.aws_iam_roles.administrator-sso-role.arns)[0], "aws-reserved/sso.amazonaws.com/", "")
        username    = "administrator"
      },
      # { #2
      #   groups   = [
      #     "developer"
      #   ]
      #   rolearn     = data.aws_iam_role.developer-role.arn
      #   username    = "developer"
      # },
      { #3
        groups   = [
          "readonly"
        ]
        rolearn     = replace(tolist(data.aws_iam_roles.readonly-sso-role.arns)[0], "aws-reserved/sso.amazonaws.com/", "")
        username    = "readonly"
      },
      # { #4
      #   groups   = [
      #     "developers"
      #   ]
      #   rolearn     = data.aws_iam_role.developers-role.arn
      #   username    = "developers"
      # }
    ]
  }

  cluster_role = [
    {
      name = "cluster-role-${local.eks-auth-cfm.default_map_roles[0].username}"
      rule = [
        {
          apiGroups   = ["*"]
          resources   = ["*"]
          verbs       = ["*"]
        }
      ]
    },
    # { #Developers
    #   name = "cluster-role-${local.eks-auth-cfm.default_map_roles[4].username}"
    #   rule = [
    #     {
    #       apiGroups   = ["*"]
    #       resources   = ["*"]
    #       verbs       = ["get", "list", "watch"]
    #     }
    #   ]
    # },
    {
      name = "cluster-role-${local.eks-auth-cfm.default_map_roles[1].username}"
      rule = [
        {
          apiGroups   = ["*"]
          resources   = ["*"]
          verbs       = ["get", "list", "watch"]
        }
      ]
    }
  ]

  cluster_role_binding = [
    {
      name = "cluster-role-binding-${local.eks-auth-cfm.default_map_roles[0].username}"
      subjects = [
        {
          kind        = "Group"
          name        = local.eks-auth-cfm.default_map_roles[0].username
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
    # { # Developers
    #   name = "cluster-role-binding-${local.eks-auth-cfm.default_map_roles[4].username}"
    #   subjects = [
    #     {
    #       kind        = "Group"
    #       name        = local.eks-auth-cfm.default_map_roles[4].username
    #       apiGroup    = "rbac.authorization.k8s.io"
    #     }
    #   ]
    #   roleRef = [
    #     {
    #       kind        = "ClusterRole"
    #       name        = local.cluster_role[1].name #developer
    #       apiGroup    = "rbac.authorization.k8s.io"
    #     }
    #   ]
    # },
    {
      name = "cluster-role-binding-${local.eks-auth-cfm.default_map_roles[1].username}"
      subjects = [
        {
          kind        = "Group"
          name        = local.eks-auth-cfm.default_map_roles[1].username
          apiGroup    = "rbac.authorization.k8s.io"
        }
      ]
      roleRef = [
        {
          kind        = "ClusterRole"
          name        = local.cluster_role[1].name #developer
          apiGroup    = "rbac.authorization.k8s.io"
        }
      ]
    }
 ] 
}