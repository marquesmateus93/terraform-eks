resource "aws_eks_node_group" "iaris-general-node-group" {
  node_group_name = local.iaris-general-node-group.name
  cluster_name    = var.cluster_name
  version         = var.eks_version

  node_role_arn   = aws_iam_role.iaris-general-role-node-group.arn
  subnet_ids      = data.aws_subnets.iaris-private-subnets.ids

  ami_type        = var.ami_type
  capacity_type   = var.capacity_type
  instance_types = local.iaris-general-node-group.instance_types

  scaling_config {
    desired_size  = var.scaling_config.desired_size
    max_size      = var.scaling_config.max_size
    min_size      = var.scaling_config.min_size
  }

  update_config {
    max_unavailable = var.max_unavailable
  }

  tags = merge({Name = local.iaris-general-node-group.name},
              var.tags)

  depends_on = [
    aws_iam_role.iaris-general-role-node-group
  ]
}