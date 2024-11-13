resource "aws_grafana_workspace" "grafana" {
    count                    = var.is_enabled ? 1:0

    name                     = local.grafana.name
    grafana_version          = local.grafana.grafana_version
    data_sources             = var.data_sources 

    account_access_type      = local.grafana.account_access_type
    authentication_providers = local.grafana.authentication_providers
    permission_type          = local.grafana.permission_type
    role_arn                 = aws_iam_role.grafana-role[*].arn

    vpc_configuration {
        subnet_ids         = data.aws_subnets.private-subnets.ids
        security_group_ids = [
            aws_security_group.grafana-security-group[*].id
        ]
    }

    tags = merge({Name = local.grafana.name},
                var.tags)
    
    depends_on = [
        aws_iam_role_policy.grafana-role-policy,
        aws_security_group.grafana-security-group
    ]
}