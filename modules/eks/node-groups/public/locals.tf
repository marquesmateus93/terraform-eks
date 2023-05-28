locals {
  node_group_name     = "${var.cluster_name}-public"
  security_group_name = "${var.cluster_name}-public-node-group"
  iam_role_name       = "${var.prefix_name}-public-node-group"
}