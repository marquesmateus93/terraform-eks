locals {
  nginx-controller = {
    name = lower("${var.prefix_name}-nginx-${var.tags["environment"]}")

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