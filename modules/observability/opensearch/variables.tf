variable "prefix_name" {
    description = "Resources prefix name."
    type        = string
    validation {
    condition = can(
        regex(
            "[a-z-]",
            var.prefix_name
        )
    )
    error_message = "The prefix name must contain just lowercase and hyphens."
    }
}

variable "is_enabled" {
    description = "Deploy or remove the resource or not."
    type        = bool
    default     = true
    validation {
    condition = (
        var.is_enabled == true ||
        var.is_enabled == false
    )
    error_message = "The enable/disable flag must be 'true' or 'false'."
    }
}

variable "engine_version" {
  description = "OpenSearch or ElasticSearch version."
  type        = string
  default     = "2.13"
  validation {
    condition = (
      can(
        regex(
          "(Elasticsearch|OpenSearch)_\\d{1,2}\\.\\d{1,2}",
          var.engine_version
        )
      )
    )
    error_message = "Invalid Engine Version. Format: Elasticsearch|OpenSearch_X.Y"
  }
}

variable "cluster_config" {
  description = ""
  type        = object({
    instance_type   = string
    instance_count  = string
  })

  default = {
    instance_type   = "t3.small.search"
    instance_count  = "1"
  }

  validation {
    condition = (
      can(
        regex(
          "((t3).(small|medium)|(m5).(large|xlarge|2xlarge|4xlarge|12xlarge)|(m6g).(large|xlarge|2xlarge|4xlarge|8xlarge|12xlarge)|(m7g).(large|xlarge|2xlarge|4xlarge|8xlarge|12xlarge|16xlarge)|(c5).(large|xlarge|2xlarge|4xlarge|9xlarge|18xlarge)|(c6g).(large|xlarge|2xlarge|4xlarge|8xlarge|12xlarge)|(c7g).(large|xlarge|2xlarge|4xlarge|8xlarge|12xlarge|16xlarge)|(r5).(large|xlarge|2xlarge|4xlarge|12xlarge)|(r6g).(large|xlarge|2xlarge|4xlarge|8xlarge|12xlarge)|(r6gd).(large|xlarge|2xlarge|4xlarge|8xlarge|12xlarge|16xlarge)|(r7g).(medium|large|xlarge|2xlarge|4xlarge|8xlarge|12xlarge|16xlarge)|(r7gd).(large|xlarge|2xlarge|4xlarge|8xlarge|12xlarge|16xlarge)|(i3).(large|xlarge|2xlarge|4xlarge|8xlarge|16xlarge)|(im4gn).(large|xlarge|2xlarge|4xlarge|8xlarge|16xlarge)|(or1).(medium|large|xlarge|2xlarge|4xlarge|8xlarge|12xlarge|16xlarge)).search",
          var.cluster_config.instance_type
        )
      )
    )
    error_message = "Provide a valid AWS OpenSearch instance type."
  }

  validation {
    condition = (
      can(
        regex(
          "\\b([1-9]|10)\\b",
          var.cluster_config.instance_count
        )
      )
    )
    error_message = "Out of range. Choose a value between 1-10."
  }
}

variable "ebs" {
  description = ""
  type = object({
    ebs_enabled = bool
    iops        = number
    throughput  = number
    volume_size = string
    volume_type = string
  })

  default = {
    ebs_enabled = true
    iops        = 3000
    throughput  = 125
    volume_size = "100"
    volume_type = "gp3"
  }
  
  validation {
    condition = (
      var.ebs.ebs_enabled == true ||
      var.ebs.ebs_enabled == false
    )
    error_message = "Must to be a boolean value."
  }

  validation {
      condition = (
        var.ebs.iops >= 3000 &&
        var.ebs.iops <= 5000
      )
      error_message = "Out of range. Choose a value between 3000-5000."
    }

  validation {
      condition = (
        var.ebs.throughput >= 125 &&
        var.ebs.throughput <= 593
      )
      error_message = "Out of range. Choose a value between 125-593."
    }

  validation {
      condition = (
        var.ebs.volume_size >= 100 &&
        var.ebs.volume_size <= 1000
      )
      error_message = "Out of range. Choose a value between 100-1000."
    }

  validation {
      condition = (
        var.ebs.volume_type == "gp2" ||
        var.ebs.volume_type == "gp3"
      )
      error_message = "Invalid volume type. Choose 'gp2' or 'gp3'."
  }
}

variable "subnets" {
  description = "Private subnets name or prefix."
  type        = list(string)
  default     = []
  validation {
    condition = alltrue([
      for item in var.subnets : can(
        regex(
          "([a-z0-9-])",
          item
        )
      )
    ])
    error_message = "The subnet name must contain just lowercase, numbers and hyphens."
  }
}

variable "encrypt_at_rest" {
  description = "At rest node ecryption."
  type        = bool
  validation {
    condition = (
      var.encrypt_at_rest == true ||
      var.encrypt_at_rest == false
    )
    error_message = "Must to be a boolean value."
  }
}

variable "domain_endpoint_options" {
  description = "Security access options."
  type = object({
    enforce_https       = bool
    tls_security_policy = string
  })
  default = {
    enforce_https       = true
    tls_security_policy = "Policy-Min-TLS-1-2-2019-07"
  }

  validation {
    condition = (
      var.domain_endpoint_options.enforce_https == true ||
      var.domain_endpoint_options.enforce_https == false
    )
    error_message = "Must to be a boolean value."
  }

  validation {
    condition = (
      var.domain_endpoint_options.tls_security_policy == "Policy-Min-TLS-1-0-2019-07" ||
      var.domain_endpoint_options.tls_security_policy == "Policy-Min-TLS-1-2-2019-07" ||
      var.domain_endpoint_options.tls_security_policy == "Policy-Min-TLS-1-2-PFS-2023-10"
    )
    error_message = "Invalid option. Choose 'Policy-Min-TLS-1-0-2019-07' or 'Policy-Min-TLS-1-2-2019-07' or 'Policy-Min-TLS-1-2-PFS-2023-10'."
  }
}

variable "node_to_node_encryption" {
  description = "Encryption node."
  type        = bool

  validation {
    condition = (
      var.node_to_node_encryption == true ||
      var.node_to_node_encryption == false
    )
    error_message = "Must to be a boolean value."
  }
}

variable "advanced_security_options" {
  description = "Seucrity access options and SAML related authentication."
  type = object({
    enabled                         = bool
    anonymous_auth_enabled          = bool
    internal_user_database_enabled  = bool
  })

  default = {
    enabled                         = true
    anonymous_auth_enabled          = false
    internal_user_database_enabled  = true
  }

  validation {
    condition = (
      var.advanced_security_options.enabled == true ||
      var.advanced_security_options.enabled == false
    )
    error_message = "Must to be a boolean value."
  }

  validation {
    condition = (
      var.advanced_security_options.anonymous_auth_enabled == true ||
      var.advanced_security_options.anonymous_auth_enabled == false
    )
    error_message = "Must to be a boolean value."
  }

  validation {
    condition = (
      var.advanced_security_options.internal_user_database_enabled == true ||
      var.advanced_security_options.internal_user_database_enabled == false
    )
    error_message = "Must to be a boolean value."
  }
}

variable "saml_options" {
  description = "SMAL authentication configurations."
  type        = object({
    enabled                 = bool
    entity_id               = string
    metadata_content        = any
    roles_key               = string
    master_backend_role     = string
    session_timeout_minutes = number
  })

  default = {
    enabled                 = true
    entity_id               = ""
    metadata_content        = ""
    roles_key               = "Role"
    master_backend_role     = "administrator"
    session_timeout_minutes = 90
  }

  validation {
    condition = (
      var.saml_options.enabled == true ||
      var.saml_options.enabled == false
    )
    error_message = "Must to be a boolean value."
  }

  validation {
    condition = (
      can(
        regex(
          "(https:\\/\\/)(portal.sso)(\\.(us(-gov)?|ap|ca|cn|eu|sa)-(central|(north|south)?(east|west)?)-([1-5]))(\\.amazonaws.com\\/saml\\/assertion)(\\/([a-zA-Z0-9]{44}))",
          var.saml_options.entity_id
        )
      )
    )
    error_message = "Provide the IAM Identity Center group ID."
  }

  validation {
    condition = (
      var.saml_options.metadata_content != null
    )
    error_message = "Content cannot be empty."
  }

  validation {
    condition = (
      var.saml_options.roles_key == "Role"
    )
    error_message = "Provide the role key."
  }

  validation {
    condition = (
      var.saml_options.master_backend_role != null
    )
    error_message = "Provide a valid IAM Identity Center applications SAML XML file."
  }

  validation {
      condition = (
        var.saml_options.session_timeout_minutes >= 1 &&
        var.saml_options.session_timeout_minutes <= 1440
      )
      error_message = "Out of range. Choose a value between 1-1440."
    }
}

variable "secret_string" {
  description = "Key/Value secret username value."
  type        = object({
    username_key_name = string
    password_key_name = string
  })

  default = {
    username_key_name = "username"
    password_key_name = "password"
  }

  validation {
    condition = (
      var.secret_string != null
    )
    error_message = "Content cannot be empty."
  }

  validation {
    condition = (
      var.secret_string != null
    )
    error_message = "Content cannot be empty."
  }
}

variable "tags" {
  description = "Tracking tags."
  type        = map(string)
  validation {
    condition = alltrue ([
      for tag in keys(var.tags) : contains([
          "environment",
          "creator_id",
          "powered_by"
        ],tag
      )
    ])
    error_message = "Tags must contain at least: 'environment', 'creator_id' and 'powered_by'."
  }
}