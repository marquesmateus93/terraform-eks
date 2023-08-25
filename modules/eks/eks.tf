resource "aws_eks_cluster" "iaris-eks" {
    name        = local.iaris-eks.name
    version     = var.eks_version
    role_arn    = aws_iam_role.iaris-eks-role.arn

    vpc_config {
        endpoint_public_access  = local.iaris-eks.vpc_config.endpoint_public_access
        endpoint_private_access = local.iaris-eks.vpc_config.endpoint_private_access
        public_access_cidrs     = local.iaris-eks.vpc_config.public_access_cidrs
        subnet_ids              = data.aws_subnets.subnets.ids
    }

    enabled_cluster_log_types = var.log_types

    kubernetes_network_config {
      service_ipv4_cidr = var.kubernetes_network_config.service_ipv4_cidr
      ip_family         = var.kubernetes_network_config.ip_family
    }

    tags = merge({Name = local.iaris-eks.name},
                var.tags)

    depends_on = [
        aws_iam_role_policy_attachment.iaris-eks-policy-attachment
    ]
}