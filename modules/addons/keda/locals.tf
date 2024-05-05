locals {
  news-keda-helm = {
    name                  = "${var.prefix_name}-keda-${var.tags["environment"]}"
    create_namespace      = true
  }
}