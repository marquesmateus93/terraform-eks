locals {
  cluster-autoscaler = {
    name = lower("${var.prefix_name}-as-${var.tags["environment"]}")
  }

  cluster-autoscaler-role = {
    name                  = "${var.prefix_name}-as-role-${var.tags["environment"]}"
    service_account_name  = "${var.prefix_name}-as-sa-${var.tags["environment"]}"
  }
}