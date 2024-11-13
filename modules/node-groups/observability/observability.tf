resource "aws_eks_node_group" "observability-ng" {
  node_group_name = local.observability-ng.name
  cluster_name    = var.cluster_name
  version         = var.eks_version

  node_role_arn   = aws_iam_role.observability-role-ng.arn
  subnet_ids      = data.aws_subnets.private-subnets.ids

  ami_type        = var.ami_type
  release_version = nonsensitive(data.aws_ssm_parameter.eks-ami-release-version.value)
  capacity_type   = var.capacity_type
  instance_types  = local.observability-ng.instance_types

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
    key     = local.observability-ng.taint.key
    value   = local.observability-ng.taint.value
    effect  = local.observability-ng.taint.effect
  }

  labels = {
    "${local.observability-ng.labels.key}" = local.observability-ng.labels.value
    "${local.observability-ng.labels.key}" = local.observability-ng.labels.value
  }

  tags = merge({Name = local.observability-ng.name},
              var.tags)

  depends_on = [
    aws_iam_role.observability-role-ng
  ]
}

resource "aws_autoscaling_group_tag" "observability-asg-tag" {
  count = length(local.observability-asg-tag.tag)

  autoscaling_group_name = aws_eks_node_group.observability-ng.resources[0].autoscaling_groups[0].name

  tag {
    key                 = local.observability-asg-tag.tag[count.index].key
    value               = local.observability-asg-tag.tag[count.index].value
    propagate_at_launch = local.observability-asg-tag.tag[count.index].propagate_at_launch
  }

  depends_on = [
    aws_eks_node_group.observability-ng
  ]
}