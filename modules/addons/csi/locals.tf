locals {
  iaris-csi-helm = {
    name                  = "${var.prefix_name}-csi-helm-${var.tags["environment"]}"
    service_account_name  = "${var.prefix_name}-csi-service-account-${var.tags["environment"]}"
  }

  iaris-csi-role = {
    name   = "${var.prefix_name}-iaris-csi-role-${var.tags["environment"]}"
  }
}