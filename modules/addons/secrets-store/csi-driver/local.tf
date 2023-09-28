locals {
  iaris-csi-secrets-store = {
    name = lower("${var.prefix_name}-secrets-store-helm-${var.tags["environment"]}")

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