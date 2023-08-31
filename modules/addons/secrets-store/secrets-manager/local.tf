locals {
  iaris-aws-secrets-store = {
    name = lower("${var.prefix_name}-aws-secrets-manager-${var.tags["environment"]}")
  }
}