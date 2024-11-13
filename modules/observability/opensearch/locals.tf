locals {
    opensearch = {
        domain_name     = lower("${var.prefix_name}-opensearch-${var.tags["environment"]}")

        cluster_config = {
            instance_type   = var.cluster_config.instance_type
            instance_count  = var.cluster_config.instance_count
        }

        ebs_options = {
            ebs_enabled = var.ebs.ebs_enabled
            iops        = tostring(var.ebs.iops)
            throughput  = tostring(var.ebs.throughput)
            volume_size = var.ebs.volume_size
            volume_type = var.ebs.volume_type
        }

        encrypt_at_rest = {
            enabled = var.encrypt_at_rest
        }

        domain_endpoint_options = {
            enforce_https       = var.domain_endpoint_options.enforce_https
            tls_security_policy = var.domain_endpoint_options.tls_security_policy
        }

        node_to_node_encryption = {
            enabled = var.node_to_node_encryption
        }

        advanced_security_options = {
            enabled                         = var.advanced_security_options.enabled
            anonymous_auth_enabled          = var.advanced_security_options.anonymous_auth_enabled
            internal_user_database_enabled  = var.advanced_security_options.internal_user_database_enabled
        }

        timeouts = {
            create = "40m"
            update = "40m"
            delete = "20m"
        }
    }

    domain-saml = {
        enabled                 = var.saml_options.enabled
        entity_id               = var.saml_options.entity_id
        metadata_content        = var.saml_options.metadata_content
        roles_key               = var.saml_options.roles_key
        master_backend_role     = var.saml_options.master_backend_role
        session_timeout_minutes = tostring(var.saml_options.session_timeout_minutes)
    }
}