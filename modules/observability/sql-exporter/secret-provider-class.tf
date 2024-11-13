resource "kubernetes_manifest" "secret-provider-class" {
  count    = var.is_enabled ? 1:0

  manifest = {
  apiVersion = "secrets-store.csi.x-k8s.io/v1"
  kind       = "SecretProviderClass"
  metadata = {
      name      = local.secret-provider-class.name
      namespace = var.deployment.namespace
  }
  spec = {
      provider = "aws"
      secretObjects = [{
        secretName  = local.secret-provider-class.secret_name
        type        = "Opaque"
        data = [
            {
              objectName = "mssql_user"
              key = "MSSQL_USER"
            },
            {
              objectName = "mssql_password"
              key = "MSSQL_PASSWORD"
          }
        ]
      }]
      parameters  = ({
        objects =  <<-EOF
        - objectName: "${data.aws_secretsmanager_secret.sql-exporter-secrets-manager.name}"
          objectType: "secretsmanager"
          jmesPath:
          - path: "mssql_user"
            objectAlias: "mssql_user"
          - path: "mssql_password"
            objectAlias: "mssql_password"
        EOF
      })
    }
  }
}