resource "aws_eks_node_group" "public" {
    node_group_name = local.node_group_name
    cluster_name    = var.cluster_name
    version         = var.eks_version

    node_role_arn   = aws_iam_role.public-eks-node-group.arn
    subnet_ids      = data.aws_subnets.public.ids

    ami_type        = var.ami_type
    capacity_type   = var.capacity_type
    instance_types = [var.instance_types.dev]

    dynamic "remote_access" {
      for_each = aws_security_group.public-eks-node-group
      content {
        ec2_ssh_key               = var.ec2_ssh_key
        source_security_group_ids = [aws_security_group.public-eks-node-group.id]
      }
    }

    scaling_config {
      desired_size  = var.scaling_config.desired_size
      max_size      = var.scaling_config.max_size
      min_size      = var.scaling_config.min_size
    }

    update_config {
      max_unavailable = var.max_unavailable
    }

    tags = merge({name = local.node_group_name},
                var.tags)
}