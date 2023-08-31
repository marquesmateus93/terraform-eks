locals {
  iaris-csi-secrets-store = {
    name = lower("${var.prefix_name}-secrets-store-helm-${var.tags["environment"]}")
  }
}