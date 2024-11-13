locals {
  csi-secrets-store = {
    name = lower("${var.prefix_name}-secrets-store-${var.tags["environment"]}")

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
}