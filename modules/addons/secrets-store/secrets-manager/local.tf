locals {
  iaris-aws-secrets-store = {
    name = lower("${var.prefix_name}-aws-secrets-manager-${var.tags["environment"]}")

    tolerations = {
      gpu = {
        key       = "nvidia.com/gpu"
        operator  = "Exists"
        effect    = "NoSchedule"
      }
      behaviour_audio = {
        key       = "behaviour/audio"
        operator  = "Exists"
        effect    = "NoSchedule"
      }
      behaviour_video = {
        key       = "behaviour/video"
        operator  = "Exists"
        effect    = "NoSchedule"
      }
    }
  }
}