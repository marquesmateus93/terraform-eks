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

variable "deployment" {
  description = "Deployment metadata."
  type = object({
    namespace                     = string
    replicas                      = string
    rollingupdate_maxsurge        = string
    rollingupdate_maxunavailable  = string
    image                         = string
    port                          = string
    resources_limits_cpu          = string
    resources_limits_memory       = string
    resources_requests_cpu        = string
    resources_requests_memory     = string
  })

  default = {
    namespace                     = "sql-exporter"
    replicas                      = "1"
    rollingupdate_maxsurge        = "0"
    rollingupdate_maxunavailable  = "1"
    image                         = "ghcr.io/justwatchcom/sql_exporter:latest"
    port                          = "9237"
    resources_limits_cpu          = "250m"
    resources_limits_memory       = "32Mi"
    resources_requests_cpu        = "5m"
    resources_requests_memory     = "16Mi"
  }

  validation {
    condition = can(
      regex(
        "([a-z-]{2,})",
        var.deployment.namespace
      )
    )
    error_message = "The namespace name must contain just owercase, hyphens, and two characters at least."
  }

  validation {
    condition = can(
      regex(
        "([0-9])",
        var.deployment.replicas
      )
    )
    error_message = "Must be a string number."
  }

  validation {
    condition = can(
      regex(
        "([0-9])",
        var.deployment.rollingupdate_maxsurge
      )
    )
    error_message = "Must be a string number."
  }

  validation {
    condition = can(
      regex(
        "([0-9])",
        var.deployment.rollingupdate_maxunavailable
      )
    )
    error_message = "Must be a string number."
  }

  validation {
    condition = can(
      regex(
        "(https:\\/\\/)?[a-z-]{2,}(\\.[a-z]{2,})(\\/.[a-z]{2,})(\\/.[a-z_]{2,})(:([\\w.\\-_]{1,127})|)",
        var.deployment.image
      )
    )
    error_message = "The URL pattern not allowed."
  }

  validation {
    condition = can(
      regex(
        "^([1-9][0-9]{0,3}|[1-5][0-9]{4}|6[0-4][0-9]{3}|65[0-4][0-9]{2}|655[0-2][0-9]|6553[0-5])$",
        var.deployment.port
      )
    )
    error_message = "Provide a valid port number."
  }

  validation {
    condition = can(
      regex(
        "([+-]?[0-9.]+)([m]?)",
        var.deployment.resources_limits_cpu
      )
    )
    error_message = "Provide a valid CPU value."
  }

  validation {
    condition = can(
      regex(
        "([+-]?[0-9.]+)(Gi|Mi)?",
        var.deployment.resources_limits_memory
      )
    )
    error_message = "Provide a valid memory value."
  }

  validation {
    condition = can(
      regex(
        "([+-]?[0-9.]+)([m]?)",
        var.deployment.resources_requests_cpu
      )
    )
    error_message = "Provide a valid CPU value."
  }

  validation {
    condition = can(
      regex(
        "([+-]?[0-9.]+)(Gi|Mi)?",
        var.deployment.resources_requests_memory
      )
    )
    error_message = "Provide a valid memory value."
  }

}

variable "configmap_job_query" {
  description = "SQL job manifest."
  type        = any
  validation {
    condition = (
      var.configmap_job_query != null
    )
    error_message = "It must to have a least one query."
  }
}

variable "rds" {
  description = "RDS instance name."
  type        = object({
    instance_name = string
    base_name     = string
  })
  
  default = {
    instance_name = ""
    base_name     = ""
  }
}

variable "oidc_provider" {
  description = "OIDC EKS ARN."
  type        = string
  validation {
    condition = can(
      regex(
        "(arn:aws:iam::)([0-9]{12})(:oidc-provider\\/)(oidc.eks.)(us(-gov)?|ap|ca|cn|eu|sa)-(central|(north|south)?(east|west)?)-\\d(.amazonaws.com\\/id\\/)([A-Z0-9]{32})",
        var.oidc_provider
      )
    )
    error_message = "Value doesn't match with OIDC URL pattern."
  }
}

variable "tags" {
    description = "Tracking tags."
    type        = map(string)
    validation {
        condition = alltrue([
            for item in keys(var.tags) : contains([
                "environment", "creator_id", "powered_by"
                ], item
            )
        ])
    error_message = "Tags must contain at least: 'environment', 'creator_id' and 'powered_by'."
    }
}