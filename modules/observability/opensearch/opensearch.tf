resource "aws_opensearch_domain" "opensearch" {
    count           = var.is_enabled ? 1:0

    domain_name     = local.opensearch.domain_name
    engine_version  = var.engine_version
    
    cluster_config {
        instance_type   = local.opensearch.cluster_config.instance_type
        instance_count  = local.opensearch.cluster_config.instance_count
    }

    ebs_options {
        ebs_enabled = local.opensearch.ebs_options.ebs_enabled
        iops        = local.opensearch.ebs_options.iops
        throughput  = local.opensearch.ebs_options.throughput
        volume_size = local.opensearch.ebs_options.volume_size
        volume_type = local.opensearch.ebs_options.volume_type
    }

    encrypt_at_rest {
        enabled = local.opensearch.encrypt_at_rest.enabled
    }

    domain_endpoint_options {
        enforce_https         = local.opensearch.domain_endpoint_options.enforce_https
        tls_security_policy   = local.opensearch.domain_endpoint_options.tls_security_policy
    }

    node_to_node_encryption {
        enabled = local.opensearch.node_to_node_encryption.enabled
    }

    advanced_security_options {
        enabled                         = local.opensearch.advanced_security_options.enabled
        anonymous_auth_enabled          = local.opensearch.advanced_security_options.anonymous_auth_enabled
        internal_user_database_enabled  = local.opensearch.advanced_security_options.internal_user_database_enabled
        master_user_options {
            master_user_name      = module.secrets-manager-version[count.index].username
            master_user_password  = module.secrets-manager-version[count.index].password
        }
    }           

    access_policies = data.aws_iam_policy_document.opensearch-access-policy.json

    timeouts {
        create = local.opensearch.timeouts.create
        update = local.opensearch.timeouts.update
        delete = local.opensearch.timeouts.delete
    }

    tags = merge({Name = local.opensearch.domain_name},
                var.tags)
    
    depends_on = [
        module.secrets-manager-version
    ]
}