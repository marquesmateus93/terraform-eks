locals {
  iaris-service-monitors = {
    name   = lower("${var.prefix_name}-service-monitors-helm-${var.tags["environment"]}")
  }

  iaris-metagpu = {
    name              = lower("${var.prefix_name}-metagpu-helm-${var.tags["environment"]}")
    create_namespace  = true
  }
}