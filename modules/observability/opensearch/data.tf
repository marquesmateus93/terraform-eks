data "aws_region" "region" {}

data "aws_caller_identity" "caller-identity" {}

data "aws_secretsmanager_secret" "opensearch-secrets-manager" {
    name = "${var.prefix_name}-secrets-manager-${var.tags["environment"]}"
}

data "aws_iam_policy_document" "opensearch-access-policy" {
    statement {
        effect = "Allow"
        principals {
            type        = "*"
            identifiers = [
                "*"
            ]
        }
        actions   = [
            "es:*"
        ]
        resources = [
            "arn:aws:es:${data.aws_region.region.name}:${data.aws_caller_identity.caller-identity.account_id}:domain/${local.opensearch.domain_name}/*"
        ]
    }
}