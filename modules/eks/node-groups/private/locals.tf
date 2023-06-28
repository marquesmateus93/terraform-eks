locals {
  node_group_name             = "${var.cluster_name}-private"
  bastion_security_group_name = "${var.cluster_name}-node-group"
  rds_security_group_name     = "${var.cluster_name}-rds"
  iam_role_name               = "${var.prefix_name}-private-node-group"
  iam_role_policy             = "${var.prefix_name}-role-policy"
}