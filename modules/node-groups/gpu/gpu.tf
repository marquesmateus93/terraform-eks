resource "aws_eks_node_group" "gpu-ng" {
  node_group_name = local.gpu-ng.name
  cluster_name    = var.cluster_name
  version         = var.eks_version

  node_role_arn   = aws_iam_role.gpu-role-ng.arn
  subnet_ids      = data.aws_subnets.private-subnets.ids

  ami_type              = var.ami_type
  release_version       = nonsensitive(data.aws_ssm_parameter.eks-ami-release-version.value)
  capacity_type         = var.capacity_type
  instance_types        = local.gpu-ng.instance_types
  force_update_version  = local.gpu-ng.force_update_version

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
    key     = local.gpu-ng.taint.gpu.key
    value   = local.gpu-ng.taint.gpu.value
    effect  = local.gpu-ng.taint.gpu.effect
  }

  labels = {
    "${local.gpu-ng.labels.gpu[0].key}" = local.gpu-ng.labels.gpu[0].value
    "${local.gpu-ng.labels.gpu[1].key}" = local.gpu-ng.labels.gpu[1].value
  }


  tags = merge({Name = local.gpu-ng.name},
              var.tags)

  depends_on = [
    aws_iam_role.gpu-role-ng
  ]
}

resource "aws_autoscaling_group_tag" "gpu-asg-tag" {
  count = length(local.gpu-asg-tag.tag)

  autoscaling_group_name = aws_eks_node_group.gpu-ng.resources[0].autoscaling_groups[0].name

  tag {
    key                 = local.gpu-asg-tag.tag[count.index].key
    value               = local.gpu-asg-tag.tag[count.index].value
    propagate_at_launch = local.gpu-asg-tag.tag[count.index].propagate_at_launch
  }

  depends_on = [
    aws_eks_node_group.gpu-ng
  ]
}