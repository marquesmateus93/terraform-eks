resource "aws_eks_node_group" "iaris-behaviour-video-node-group" {
  node_group_name = local.iaris-behaviour-video-node-group.name
  cluster_name    = var.cluster_name
  version         = var.eks_version

  node_role_arn   = aws_iam_role.iaris-behaviour-video-role-node-group.arn
  subnet_ids      = data.aws_subnets.iaris-private-subnets.ids

  ami_type        = var.ami_type
  capacity_type   = var.capacity_type
  instance_types  = local.iaris-behaviour-video-node-group.instance_types

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
    key     = local.iaris-behaviour-video-node-group.taint.video.key
    value   = local.iaris-behaviour-video-node-group.taint.video.value
    effect  = local.iaris-behaviour-video-node-group.taint.video.effect
  }

  labels = {
    "${local.iaris-behaviour-video-node-group.labels.video[0].key}" = local.iaris-behaviour-video-node-group.labels.video[0].value
  }

  tags = merge({Name = local.iaris-behaviour-video-node-group.name},
              var.tags)

  depends_on = [
    aws_iam_role.iaris-behaviour-video-role-node-group
  ]
}

resource "aws_autoscaling_group_tag" "iaris-behaviour-video-autoscaling-group-tag" {
  count = length(local.iaris-behaviour-video-autoscaling-group-tag.tag)

  autoscaling_group_name = aws_eks_node_group.iaris-behaviour-video-node-group.resources[0].autoscaling_groups[0].name

  tag {
    key                 = local.iaris-behaviour-video-autoscaling-group-tag.tag[count.index].key
    value               = local.iaris-behaviour-video-autoscaling-group-tag.tag[count.index].value
    propagate_at_launch = local.iaris-behaviour-video-autoscaling-group-tag.tag[count.index].propagate_at_launch
  }

  depends_on = [
    aws_eks_node_group.iaris-behaviour-video-node-group
  ]
}