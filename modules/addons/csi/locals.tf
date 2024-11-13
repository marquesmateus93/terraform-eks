locals {
  csi = {
    name                  = "${var.prefix_name}-csi-${var.tags["environment"]}"
    service_account_name  = "${var.prefix_name}-csi-sa-${var.tags["environment"]}"

    tolerations = {
      general = {
        key       = "general"
        operator  = "Exists"
        effect    = "NoSchedule"
      },
      observability = {
        key       = "observability"
        operator  = "Exists"
        effect    = "NoSchedule"
      },
      gpu = {
        key       = "gpu"
        operator  = "Exists"
        effect    = "NoSchedule"
      }
    }
  }

  csi-role = {
    name   = "${var.prefix_name}-csi-role-${var.tags["environment"]}"
  }
}