data "aws_secretsmanager_secret" "sql-exporter-secrets-manager" {
    name = "${var.prefix_name}-secrets-manager-${var.tags["environment"]}"
}

data "aws_eks_cluster" "eks-cluster" {
    name = "${var.prefix_name}-eks-${var.tags["environment"]}"
}

data "tls_certificate" "certificate" {
    url = data.aws_eks_cluster.eks-cluster.identity[0].oidc[0].issuer
}

data "aws_db_instance" "rds-instance" {
    count = var.is_enabled ? 1:0
    db_instance_identifier = var.rds.instance_name
}