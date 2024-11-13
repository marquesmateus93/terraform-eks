resource "aws_opensearch_domain_saml_options" "domain-saml" {
    count       = var.is_enabled ? 1:0

    domain_name = aws_opensearch_domain.opensearch[0].domain_name
    saml_options {
        enabled = local.domain-saml.enabled
        idp {
            entity_id           = local.domain-saml.entity_id
            metadata_content    = local.domain-saml.metadata_content
        }
        roles_key               = local.domain-saml.roles_key
        master_backend_role     = local.domain-saml.master_backend_role
        session_timeout_minutes = local.domain-saml.session_timeout_minutes
    }
}