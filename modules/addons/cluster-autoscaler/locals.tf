locals {
  iaris-cluster-autoscaler-helm = {
    name  = lower("${var.prefix_name}-autoscaler-helm-${var.tags["environment"]}")
  }

  iaris-cluster-autoscaler-role = {
    name                  = "${var.prefix_name}-autoscaler-role-${var.tags["environment"]}"
    service_account_name  = "${var.prefix_name}-autoscaler-service-account-${var.tags["environment"]}"
  }
}