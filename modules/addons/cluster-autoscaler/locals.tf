locals {
  news-cluster-autoscaler = {
    name = lower("${var.prefix_name}-autoscaler-${var.tags["environment"]}")
  }

  news-cluster-autoscaler-role = {
    name                  = "${var.prefix_name}-autoscaler-role-${var.tags["environment"]}"
    service_account_name  = "${var.prefix_name}-autoscaler-sa-${var.tags["environment"]}"
  }
}