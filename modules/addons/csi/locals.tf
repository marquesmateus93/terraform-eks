locals {
  iaris-csi-helm = {
    name                  = "${var.prefix_name}-csi-helm-${var.tags["environment"]}"
    service_account_name  = "${var.prefix_name}-csi-service-account-${var.tags["environment"]}"

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

  iaris-csi-role = {
    name   = "${var.prefix_name}-csi-role-${var.tags["environment"]}"
  }
}