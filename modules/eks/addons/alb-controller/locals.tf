locals {
  helm_name   = lower("${var.prefix_name}-alb-controller-helm")
  policy_name = "${var.prefix_name}-alb-controller-policy"
  role_name   = "${var.prefix_name}-alb-controller-role"
}