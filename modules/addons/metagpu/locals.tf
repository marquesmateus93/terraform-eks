locals {
  service-monitors = {
    name   = lower("${var.prefix_name}-service-monitors-${var.tags["environment"]}")
  }

  metagpu = {
    name              = lower("${var.prefix_name}-metagpu-${var.tags["environment"]}")
    create_namespace  = true
  }
}