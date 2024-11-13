locals {
  gpu-ng = {
    name                  = "${var.prefix_name}-gpu-ng-${var.tags["environment"]}"
    instance_types        = var.tags["environment"] != "production" ? var.instance_types.non_production : var.instance_types.production
    force_update_version  = true

    taint = {
      gpu = {
        key     = "nvidia.com/gpu"
        value   = "present"
        effect  = "NO_SCHEDULE"
      }
    }

    labels  = {
      gpu   = [
        {
          key   = "accelerator"
          value = "nvidia"
        },
        {
          key   = "nvidia.com/gpu"
          value = "true"
        }
      ]
    }
  }

  gpu-asg-tag = {
    tag = [
      {
        key                 = "k8s.io/cluster-autoscaler/node-template/label/accelerator"
        value               = "nvidia"
        propagate_at_launch = true
      },
      {
        key                 = "k8s.io/cluster-autoscaler/node-template/label/nvidia.com/gpu"
        value               = "true"
        propagate_at_launch = true
      },
      {
        key                 = "k8s.io/cluster-autoscaler/node-template/taint/nvidia.com/gpu"
        value               = "present"
        propagate_at_launch = true
      },
      {
        key                 = "Name"
        value               = "${var.prefix_name}-gpu"
        propagate_at_launch = true
      }
    ]
  }

  gpu-role-ng = {
    name = "${var.prefix_name}-gpu-role-ng-${var.tags["environment"]}"
  }

  gpu-role-policy-ng = {
    name = "${var.prefix_name}-gpu-policy-ng-${var.tags["environment"]}"
  }
}