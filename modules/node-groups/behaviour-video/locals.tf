locals {
  iaris-behaviour-video-node-group = {
    name            = "${var.prefix_name}-behaviour-video-node-group-${var.tags["environment"]}"
    instance_types  = var.tags["environment"] != "production" ? var.instance_types.non_production : var.instance_types.production

    taint = {
      video = {
        key     = "behaviour/video"
        value   = "NoSchedule"
        effect  = "NO_SCHEDULE"
      }
    }

    labels  = {
      video = [
        {
          key   = "behaviour/video"
          value = "present"
        }
      ]
    }
  }

  iaris-behaviour-video-autoscaling-group-tag = {
    tag = [
      {
        key                 = "k8s.io/cluster-autoscaler/node-template/label/behaviour/video"
        value               = "present"
        propagate_at_launch = true
      },
      {
        key                 = "k8s.io/cluster-autoscaler/node-template/taint/behaviour/video"
        value               = "present"
        propagate_at_launch = true
      }
    ]
  }

  iaris-behaviour-video-role-node-group = {
    name = "${var.prefix_name}-behaviour-video-role-node-group-${var.tags["environment"]}"
  }

  iaris-behaviour-video-role-policy-node-group = {
    name = "${var.prefix_name}-behaviour-video-policy-node-group-${var.tags["environment"]}"
  }
}