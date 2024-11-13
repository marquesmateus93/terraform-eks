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

variable "account_access_type" {
    description = "Account access boards type."
    type        = string
    default     = "CURRENT_ACCOUNT"
    validation {
        condition = (
            var.account_access_type == "CURRENT_ACCOUNT" ||
            var.account_access_type == "ORGANIZATION"
        )
    error_message = "Choose'CURRENT_ACCOUNT' or 'ORGANIZATION'."
    }
}

variable "authentication_providers" {
    description = "Authentication account access boards type."
    type        = list(string)
    default     = ["AWS_SSO"]
    validation {
        condition = alltrue ([
            for authentication_provider in var.authentication_providers : can(
                regex(
                    "(AWS_SSO|SAML)",
                    authentication_provider
                )
            )
        ])
    error_message = "Choose 'AWS_SSO' or 'SAML' or both."
    }
}

variable "permission_type" {
    description = "Management"
    type        = string
    default     = "SERVICE_MANAGED"
    validation {
        condition = (
            var.permission_type == "SERVICE_MANAGED" ||
            var.permission_type == "CUSTOMER_MANAGED"
        )
    error_message = "Choose 'SERVICE_MANAGED' or 'CUSTOMER_MANAGED'."
    }
}

variable "data_sources" {
    description = "Authentication account access boards type."
    type        = list(string)
    default     = ["PROMETHEUS"]
    validation {
        condition = alltrue([
            for data_source in var.data_sources : can(
                regex(
                    "(AMAZON_OPENSEARCH_SERVICE|ATHENA|CLOUDWATCH|PROMETHEUS|REDSHIFT|SITEWISE|TIMESTREAM|XRAY)",
                    data_source
                )
            )
        ])
    error_message = "Choose one of the fallowing values or none: 'AMAZON_OPENSEARCH_SERVICE' or 'ATHENA' or 'CLOUDWATCH' or 'PROMETHEUS' or 'REDSHIFT' or 'SITEWISE' or 'TIMESTREAM' or 'XRAY'."
    }
}

variable "grafana_version" {
    description = "Grafana version number."
    type        = string
    default     = "10.4"
    validation {
        condition = can(
            regex(
                "\\d{1,2}\\.\\d{1,2}",
                var.grafana_version
            )
        )
    error_message = "Provide a valid Grafana version. The pattern is: XX.XX ."
    }
}

variable "vpc" {
    description = "VPC name."
    type        = list(string)
    default     = ["marques-vpc"]
    validation {
        condition = alltrue([
            for item in var.vpc : can(
                regex(
                    "([a-z0-9-])",
                    item
                )
            )
        ])
    error_message = "Provide at least one VPC name."
    }
}

variable "subnets" {
    description = "Private subnets name or prefix."
    type        = list(string)
    default     = [
        "marques-vpc-private-subnet"
    ]
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