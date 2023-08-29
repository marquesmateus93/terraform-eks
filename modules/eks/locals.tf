locals {
    iaris-eks = {
        name        = "${var.prefix_name}-eks-${var.tags["environment"]}"
        version     = var.eks_version

        vpc_config = {
            endpoint_private_access = var.api_endpoint.private
            endpoint_public_access  = var.api_endpoint.public
            public_access_cidrs     = var.api_endpoint.public_access_cidrs
        }
    }

    iaris-eks-role = {
        name = "${var.prefix_name}-eks-role-${var.tags["environment"]}"
        path = "/iaris/eks/development/"
    }

    iaris-eks-policy = {
        name    = "${var.prefix_name}-eks-policy-${var.tags["environment"]}"
        path    = "iaris/eks/development/"
    }

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
                rolearn     = data.aws_iam_role.iaris-genral-node-group-role.arn
                username    = "system:node:{{EC2PrivateDNSName}}"
            },
            {
                groups   = [
                    "system:bootstrappers",
                    "system:nodes"
                ]
                rolearn     = data.aws_iam_role.iaris-easyproctor-image-node-group-role.arn
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