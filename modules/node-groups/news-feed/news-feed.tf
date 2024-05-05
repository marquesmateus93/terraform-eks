resource "aws_eks_node_group" "news-feed-ng" {
  node_group_name = local.news-feed-ng.name
  cluster_name    = var.cluster_name
  version         = var.eks_version

  node_role_arn   = aws_iam_role.news-feed-role-ng.arn
  subnet_ids      = data.aws_subnets.news-feed-private-subnets.ids

  ami_type        = var.ami_type
  release_version = local.news-feed-ng.release_version
  capacity_type   = var.capacity_type
  instance_types = local.news-feed-ng.instance_types

  scaling_config {
    desired_size  = var.scaling_config.desired_size
    max_size      = var.scaling_config.max_size
    min_size      = var.scaling_config.min_size
  }

  disk_size = var.disk_space

  update_config {
    max_unavailable = var.max_unavailable
  }

  tags = merge({Name = local.news-feed-ng.name},
              var.tags)

  depends_on = [
    aws_iam_role.news-feed-role-ng
  ]
}

resource "aws_autoscaling_group_tag" "news-feed-autoscaling-group-tag" {
  count = length(local.news-feed-asg-tag.tag)

  autoscaling_group_name = aws_eks_node_group.news-feed-ng.resources[0].autoscaling_groups[0].name

  tag {
    key                 = local.news-feed-asg-tag.tag[count.index].key
    value               = local.news-feed-asg-tag.tag[count.index].value
    propagate_at_launch = local.news-feed-asg-tag.tag[count.index].propagate_at_launch
  }

  depends_on = [
    aws_eks_node_group.news-feed-ng
  ]
}