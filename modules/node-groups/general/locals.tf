locals {
  iaris-general-node-group = {
    name            = "${var.prefix_name}-general-node-group-${var.tags["environment"]}"
    instance_types  = var.tags["environment"] != "production" ? var.instance_types.non_production : var.instance_types.production
  }

  iaris-general-role-node-group = {
    name = "${var.prefix_name}-general-role-node-group-${var.tags["environment"]}"
  }

  iaris-general-role-policy-node-group = {
    name = "${var.prefix_name}-general-policy-node-group-${var.tags["environment"]}"
  }

  iaris-genral-autoscaling-group-tag = {
    tag = [
      {
        key                 = "k8s.io/cluster-autoscaler/enabled"
        value               = "false"
        propagate_at_launch = true
      }
    ]
  }
}