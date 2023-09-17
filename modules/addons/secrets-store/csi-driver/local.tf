locals {
  iaris-csi-secrets-store = {
    name = lower("${var.prefix_name}-secrets-store-helm-${var.tags["environment"]}")

    tolerations = {
        key       = "nvidia.com/gpu"
        operator  = "Exists"
        effect    = "NoSchedule"
    }
  }
}