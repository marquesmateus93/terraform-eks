locals {
  iaris-easyproctor-image-node-group = {
    name            = "${var.prefix_name}-easyproctor-image-node-group-${var.tags["environment"]}"
    instance_types  = var.tags["environment"] != "production" ? var.instance_types.non_production : var.instance_types.production

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

  iaris-easyproctor-image-autoscaling-group-tag = {
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
        key                 = "k8s.io/cluster-autoscaler/node-template/resources/nvidia.com/gpu"
        value               = "50"
        propagate_at_launch = true
      }
    ]
  }

  iaris-easyproctor-image-role-node-group = {
    name = "${var.prefix_name}-easyproctor-image-role-node-group-${var.tags["environment"]}"
  }

  iaris-easyproctor-image-role-policy-node-group = {
    name = "${var.prefix_name}-easyproctor-image-policy-node-group-${var.tags["environment"]}"
  }
}