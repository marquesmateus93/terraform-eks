locals {
  general-ng = {
    name            = "${var.prefix_name}-general-ng-${var.tags["environment"]}"
    instance_types  = var.tags["environment"] != "production" ? var.instance_types.non_production : var.instance_types.production
  }

  general-role-ng = {
    name = "${var.prefix_name}-general-role-ng-${var.tags["environment"]}"
  }

  general-role-policy-ng = {
    name = "${var.prefix_name}-general-policy-ng-${var.tags["environment"]}"
  }

  general-asg-tag = {
    tag = [
      {
        key                 = "k8s.io/cluster-autoscaler/enabled"
        value               = "false"
        propagate_at_launch = true
      },
      {
        key                 = "Name"
        value               = "${var.prefix_name}-general"
        propagate_at_launch = true
      }
    ]
  }
}