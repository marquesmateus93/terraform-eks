resource "aws_eks_cluster" "eks" {
    name        = local.eks.name
    version     = var.eks_version
    role_arn    = aws_iam_role.eks-role.arn

    vpc_config {
        endpoint_public_access  = local.eks.vpc_config.endpoint_public_access
        endpoint_private_access = local.eks.vpc_config.endpoint_private_access
        public_access_cidrs     = local.eks.vpc_config.public_access_cidrs
        subnet_ids              = data.aws_subnets.subnets.ids
    }

    enabled_cluster_log_types = var.log_types

    kubernetes_network_config {
      service_ipv4_cidr = var.kubernetes_network_config.service_ipv4_cidr
      ip_family         = var.kubernetes_network_config.ip_family
    }

    tags = merge({Name = local.eks.name},
                var.tags)

    depends_on = [
        aws_iam_role_policy_attachment.eks-policy-attachment
    ]
}