resource "aws_eks_node_group" "iaris-easyproctor-image-node-group" {
  node_group_name = local.iaris-easyproctor-image-node-group.name
  cluster_name    = var.cluster_name
  version         = var.eks_version

  node_role_arn   = aws_iam_role.iaris-easyproctor-image-role-node-group.arn
  subnet_ids      = data.aws_subnets.iaris-private-subnets.ids

  ami_type        = var.ami_type
  capacity_type   = var.capacity_type
  instance_types  = local.iaris-easyproctor-image-node-group.instance_types

  scaling_config {
    desired_size  = var.scaling_config.desired_size
    max_size      = var.scaling_config.max_size
    min_size      = var.scaling_config.min_size
  }

  disk_size = var.disk_space

  update_config {
    max_unavailable = var.max_unavailable
  }

  taint {
    key     = local.iaris-easyproctor-image-node-group.taint.gpu.key
    value   = local.iaris-easyproctor-image-node-group.taint.gpu.value
    effect  = local.iaris-easyproctor-image-node-group.taint.gpu.effect
  }

  labels = {
    "${local.iaris-easyproctor-image-node-group.labels.gpu[0].key}" = local.iaris-easyproctor-image-node-group.labels.gpu[0].value
    "${local.iaris-easyproctor-image-node-group.labels.gpu[1].key}" = local.iaris-easyproctor-image-node-group.labels.gpu[1].value
  }

  tags = merge({Name = local.iaris-easyproctor-image-node-group.name},
              var.tags)

  depends_on = [
    aws_iam_role.iaris-easyproctor-image-role-node-group
  ]
}

resource "aws_autoscaling_group_tag" "iaris-easyproctor-image-autoscaling-group-tag" {
  count = length(local.iaris-easyproctor-image-autoscaling-group-tag.tag)

  autoscaling_group_name = aws_eks_node_group.iaris-easyproctor-image-node-group.resources[0].autoscaling_groups[0].name

  tag {
    key                 = local.iaris-easyproctor-image-autoscaling-group-tag.tag[count.index].key
    value               = local.iaris-easyproctor-image-autoscaling-group-tag.tag[count.index].value
    propagate_at_launch = local.iaris-easyproctor-image-autoscaling-group-tag.tag[count.index].propagate_at_launch
  }

  depends_on = [
    aws_eks_node_group.iaris-easyproctor-image-node-group
  ]
}