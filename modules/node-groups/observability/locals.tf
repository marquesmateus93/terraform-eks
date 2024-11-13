locals {
  observability-ng = {
    name            = "${var.prefix_name}-observability-ng-${var.tags["environment"]}"
    instance_types  = var.tags["environment"] != "production" ? var.instance_types.non_production : var.instance_types.production

    taint = {
      key     = "observability"
      value   = "present"
      effect  = "NO_SCHEDULE"
    }

    labels  = {
      key   = "observability"
      value = "true"
    }
  }

  observability-role-ng = {
    name = "${var.prefix_name}-observability-role-ng-${var.tags["environment"]}"
  }

  observability-role-policy-ng = {
    name = "${var.prefix_name}-observability-policy-ng-${var.tags["environment"]}"
  }

  observability-asg-tag = {
    tag = [
      {
        key                 = "k8s.io/cluster-autoscaler/enabled"
        value               = "true"
        propagate_at_launch = true
      },
      {
        key                 = "Name"
        value               = "${var.prefix_name}-observability"
        propagate_at_launch = true
      }
    ]
  }
}