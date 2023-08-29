locals {
  iaris-csi-helm = {
    name   = lower("${var.prefix_name}-csi-helm-${var.tags["environment"]}")
  }

  iaris-csi-role = {
    name   = "${var.prefix_name}-iaris-csi-role-${var.tags["environment"]}"
  }
}