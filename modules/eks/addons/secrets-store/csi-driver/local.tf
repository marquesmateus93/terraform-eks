locals {
  #policy_name = "${var.prefix_name}-secrets-store-policy"
  #role_name   = "${var.prefix_name}-secrets-store-role"
  helm_name   = lower("${var.prefix_name}-secrets-store-helm")
}