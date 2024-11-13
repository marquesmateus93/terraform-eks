locals {
    grafana = {
        name                     = lower("${var.prefix_name}-grafana-${var.tags["environment"]}")
        grafana_version          = var.grafana_version

        account_access_type      = var.account_access_type
        authentication_providers = var.authentication_providers
        permission_type          = var.permission_type

        data_sources             = var.data_sources
    }

    grafana-role = {
        name    = lower("${var.prefix_name}-grafana-role-${var.tags["environment"]}")
    }

    grafana-policy = {
        name    = lower("${var.prefix_name}-grafana-policy-${var.tags["environment"]}")
    }

    grafana-security-group = {
        name        = "${var.prefix_name}-grafana-sg-${var.tags["environment"]}"
        description = "HTTPS internal boards access."
        vpc_id      = data.aws_vpc.vpc.id

        ingress = {
            https = {
                port        = 443
                protocol    = "tcp"
                #cidr_blocks = data.aws_vpc.vpc.cidr_block_associations[0].cidr_block
                cidr_blocks = [
                    "0.0.0.0/0"
                ]
            }
        }

        egress = {
            from_port   = 0
            to_port     = 0
            protocol    = "-1"
            cidr_blocks = [
                "0.0.0.0/0"
            ]
        }
    }
}