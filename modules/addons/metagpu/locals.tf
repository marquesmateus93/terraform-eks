locals {
  news-service-monitors = {
    name   = lower("${var.prefix_name}-service-monitors-${var.tags["environment"]}")
  }

  news-metagpu = {
    name              = lower("${var.prefix_name}-metagpu-${var.tags["environment"]}")
    create_namespace  = true
  }
}