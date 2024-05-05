locals {
  news-feed-ng = {
    name            = "${var.prefix_name}-feed-ng-${var.tags["environment"]}"
    instance_types  = var.tags["environment"] != "prod" ? var.instance_types.non_production : var.instance_types.production
    release_version = nonsensitive(data.aws_ssm_parameter.eks_ami_release_version.value)
  }

  news-feed-role-ng = {
    name = "${var.prefix_name}-feed-role-ng-${var.tags["environment"]}"
  }

  news-feed-role-policy-ng = {
    name = "${var.prefix_name}-feed-policy-ng-${var.tags["environment"]}"
  }

  news-feed-asg-tag = {
    tag = [
      {
        key                 = "k8s.io/cluster-autoscaler/enabled"
        value               = "false"
        propagate_at_launch = true
      },
      {
        key                 = "${var.prefix_name}-feed"
        value               = "false"
        propagate_at_launch = true
      }
    ]
  }
}