locals {
  policy_name = "${var.prefix_name}-csi-policy"
  role_name   = "${var.prefix_name}-csi-role"
  helm_name   = lower("${var.prefix_name}-csi-helm")
}