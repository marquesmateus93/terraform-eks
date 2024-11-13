locals {
    eks = {
        name        = "${var.prefix_name}-eks-${var.tags["environment"]}"
        version     = var.eks_version

        vpc_config = {
            endpoint_private_access = var.api_endpoint.private
            endpoint_public_access  = var.api_endpoint.public
            public_access_cidrs     = var.api_endpoint.public_access_cidrs
        }
    }

    eks-role = {
        name = "${var.prefix_name}-eks-role-${var.tags["environment"]}"
        #path = "/eks/development/"
    }

    eks-policy = {
        name    = "${var.prefix_name}-eks-policy-${var.tags["environment"]}"
        #path    = "/eks/development/"
    }
}