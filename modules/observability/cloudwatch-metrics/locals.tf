locals {
  cloudwatch-metrics = {
    name                  = "${var.prefix_name}-cloudwatch-metrics-${var.tags["environment"]}"
    create_namespace      = true
    recreate_pods         = true
    service_account_name  = "${var.prefix_name}-cloudwatch-metrics-service-account-${var.tags["environment"]}"
    
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