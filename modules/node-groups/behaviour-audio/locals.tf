locals {
  iaris-behaviour-audio-node-group = {
    name            = "${var.prefix_name}-behaviour-audio-node-group-${var.tags["environment"]}"
    instance_types  = var.tags["environment"] != "production" ? var.instance_types.non_production : var.instance_types.production

    taint = {
      audio = {
        key     = "behaviour/audio"
        value   = "NoSchedule"
        effect  = "NO_SCHEDULE"
      }
    }

    labels  = {
      audio = [
        {
          key   = "behaviour/audio"
          value = "present"
        }
      ]
    }
  }

  iaris-behaviour-audio-autoscaling-group-tag = {
    tag = [
      {
        key                 = "k8s.io/cluster-autoscaler/node-template/label/behaviour/audio"
        value               = "present"
        propagate_at_launch = true
      },
      {
        key                 = "k8s.io/cluster-autoscaler/node-template/taint/behaviour/audio"
        value               = "present"
        propagate_at_launch = true
      }
    ]
  }

  iaris-behaviour-audio-role-node-group = {
    name = "${var.prefix_name}-behaviour-audio-role-node-group-${var.tags["environment"]}"
  }

  iaris-behaviour-audio-role-policy-node-group = {
    name = "${var.prefix_name}-behaviour-audio-policy-node-group-${var.tags["environment"]}"
  }
}