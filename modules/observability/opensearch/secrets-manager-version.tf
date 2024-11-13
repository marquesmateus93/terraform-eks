module "secrets-manager-version" {
    count   = var.is_enabled ? 1:0
    source  = "git@github.com:marquesmateus93/terraform-secrets-manager//modules/secrets-manager-version//.?ref=dev"

    prefix_name = var.prefix_name

    secrets_manager_id  = data.aws_secretsmanager_secret.opensearch-secrets-manager.id
    secret_string = {
        username_key_name = "${var.secret_string.username_key_name}"
        password_key_name = "${var.secret_string.password_key_name}"
    }

    tags = {
        environment = var.tags["environment"]
        creator_id  = var.tags["creator_id"]
        powered_by  = var.tags["powered_by"]
    }
}