locals {
  node_group_name     = "${var.cluster_name}-private"
  security_group_name = "${var.cluster_name}-node-group"
  iam_role_name       = "${var.prefix_name}-private-node-group"
}