locals {
  iaris-keda-helm = {
    name                  = "${var.prefix_name}-keda-helm-${var.tags["environment"]}"
    create_namespace      = true
  }
}