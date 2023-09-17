locals {
  iaris-aws-secrets-store = {
    name = lower("${var.prefix_name}-aws-secrets-manager-${var.tags["environment"]}")

    tolerations = {
      key       = "nvidia.com/gpu"
      operator  = "Exists"
      effect    = "NoSchedule"
    }
  }
}