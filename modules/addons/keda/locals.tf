locals {
  keda = {
    name                  = "${var.prefix_name}-keda-${var.tags["environment"]}"
    create_namespace      = true
  }
}