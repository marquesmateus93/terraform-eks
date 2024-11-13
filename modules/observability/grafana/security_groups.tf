resource "aws_security_group" "grafana-security-group" {
  count                    = var.is_enabled ? 1:0

  name        = local.grafana-security-group.name
  description = local.grafana-security-group.description
  vpc_id      = local.grafana-security-group.vpc_id

  ingress {
    from_port = local.grafana-security-group.ingress.https.port
    to_port   = local.grafana-security-group.ingress.https.port
    protocol  = local.grafana-security-group.ingress.https.protocol
  }

  egress {
    from_port   = local.grafana-security-group.egress.from_port
    to_port     = local.grafana-security-group.egress.to_port
    protocol    = local.grafana-security-group.egress.protocol
    cidr_blocks = local.grafana-security-group.egress.cidr_blocks
  }

  tags = merge({Name = local.grafana-security-group.name},
              var.tags)
}