locals {
  news-alb-controller = {
    name                  = "${var.prefix_name}-alb-controller-${var.tags["environment"]}"
    service_account_name  = "${var.prefix_name}-alb-controller-sa-${var.tags["environment"]}"
  }

  news-alb-controller-role = {
    name = "${var.prefix_name}-alb-controller-role-${var.tags["environment"]}"
  }

  news-alb-controller-policy = {
    name = "${var.prefix_name}-alb-controller-policy-${var.tags["environment"]}"
  }
}