resource "aws_eks_cluster" "eks" {
    name        = local.eks_name
    version     = var.eks_version
    role_arn    = aws_iam_role.eks.arn

    vpc_config {
        endpoint_private_access = var.api_endpoint.private
        endpoint_public_access  = var.api_endpoint.public
        public_access_cidrs     = [var.api_endpoint.public_access_cidrs]
        subnet_ids              = data.aws_subnets.subnets.ids
    }

    enabled_cluster_log_types = var.log_types

    kubernetes_network_config {
      service_ipv4_cidr = var.kubernetes_network_config.service_ipv4_cidr
      ip_family         = var.kubernetes_network_config.ip_family
    }

    tags = merge({name = local.eks_name},
                var.tags)

    depends_on = [
        aws_iam_role_policy_attachment.eks
    ]
}