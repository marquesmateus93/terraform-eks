locals {
  iaris-alb-controller-helm = {
    name                  = "${var.prefix_name}-alb-controller-helm-${var.tags["environment"]}"
    service_account_name  = "${var.prefix_name}-alb-controller-service-account-${var.tags["environment"]}"
  }

  iaris-alb-controller-role = {
    name = "${var.prefix_name}-alb-controller-role-${var.tags["environment"]}"
  }

  iaris-alb-controller-policy = {
    name = "${var.prefix_name}-alb-controller-policy-${var.tags["environment"]}"
  }
}