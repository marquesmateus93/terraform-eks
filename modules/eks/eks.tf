resource "aws_eks_cluster" "news-eks" {
    name        = local.news-eks.name
    version     = var.eks_version
    role_arn    = aws_iam_role.news-eks-role.arn

    vpc_config {
        endpoint_public_access  = local.news-eks.vpc_config.endpoint_public_access
        endpoint_private_access = local.news-eks.vpc_config.endpoint_private_access
        public_access_cidrs     = local.news-eks.vpc_config.public_access_cidrs
        subnet_ids              = data.aws_subnets.subnets.ids
    }

    enabled_cluster_log_types = var.log_types

    kubernetes_network_config {
      service_ipv4_cidr = var.kubernetes_network_config.service_ipv4_cidr
      ip_family         = var.kubernetes_network_config.ip_family
    }

    tags = merge({Name = local.news-eks.name},
                var.tags)

    depends_on = [
        aws_iam_role_policy_attachment.news-eks-policy-attachment
    ]
}