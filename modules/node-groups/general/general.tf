resource "aws_eks_node_group" "general-ng" {
  node_group_name = local.general-ng.name
  cluster_name    = var.cluster_name
  version         = var.eks_version

  node_role_arn   = aws_iam_role.general-role-ng.arn
  subnet_ids      = data.aws_subnets.private-subnets.ids

  ami_type        = var.ami_type
  release_version = nonsensitive(data.aws_ssm_parameter.eks-ami-release-version.value)
  capacity_type   = var.capacity_type
  instance_types  = local.general-ng.instance_types

  scaling_config {
    desired_size  = var.scaling_config.desired_size
    max_size      = var.scaling_config.max_size
    min_size      = var.scaling_config.min_size
  }

  disk_size = var.disk_space

  update_config {
    max_unavailable = var.max_unavailable
  }

  tags = merge({Name = local.general-ng.name},
              var.tags)

  depends_on = [
    aws_iam_role.general-role-ng
  ]
}

resource "aws_autoscaling_group_tag" "general-asg-tag" {
  count = length(local.general-asg-tag.tag)

  autoscaling_group_name = aws_eks_node_group.general-ng.resources[0].autoscaling_groups[0].name

  tag {
    key                 = local.general-asg-tag.tag[count.index].key
    value               = local.general-asg-tag.tag[count.index].value
    propagate_at_launch = local.general-asg-tag.tag[count.index].propagate_at_launch
  }

  depends_on = [
    aws_eks_node_group.general-ng
  ]
}