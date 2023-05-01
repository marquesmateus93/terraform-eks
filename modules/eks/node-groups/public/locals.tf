locals {
  node_group_name     = "${var.cluster_name}-public"
  security_group_name = "${var.cluster_name}-public-node-group"
  aws_iam_role        = "${var.prefix_name}-role"
}