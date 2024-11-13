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

variable "helm" {
    description = "Helm chart properties."
    type        = object({
        nvidia-exporter = object({
            repository  = string
            chart       = string
            namespace   = string
        })
        prometheus-operator-crds = object({
            repository  = string
            chart       = string
            namespace   = string
        })
    })
    default = {
        nvidia-exporter = {
            repository  = "https://nvidia.github.io/dcgm-exporter/helm-charts"
            chart       = "dcgm-exporter"
            namespace   = "nvidia"
        }
        prometheus-operator-crds = {
            repository  = "https://prometheus-community.github.io/helm-charts"
            chart       = "prometheus-operator-crds"
            namespace   = "nvidia"
        }
    }
    validation {
    condition = can(
        regex(
            "(https:\\/\\/)?[a-zA-]{2,}(\\.[a-z]{2,})(\\.[a-z]{2,})(\\/[a-z-]{2,})?",
            var.helm.nvidia-exporter.repository
        )
    )
    error_message = "The URL pattern not allowed."
    }
    validation {
    condition = can(
        regex(
            "([a-z-]{2,})",
            var.helm.nvidia-exporter.chart
        )
    )
    error_message = "The chart name must contain just lowercase, hyphens, and two characters at least."
    }
    validation {
    condition = can(
        regex(
            "([a-z-]{2,})",
            var.helm.nvidia-exporter.namespace
        )
    )
        error_message = "The namespace name must contain just owercase, hyphens, and two characters at least."
    }

    validation {
        condition = can(
            regex(
                "(https:\\/\\/)?[a-zA-]{2,}(\\.[a-z]{2,})(\\.[a-z]{2,})(\\/[a-z-]{2,})?",
                var.helm.prometheus-operator-crds.repository
            )
        )
        error_message = "The URL pattern not allowed."
    }
    validation {
        condition = can(
            regex(
                "([a-z-]{2,})",
                var.helm.prometheus-operator-crds.chart
            )
        )
        error_message = "The chart name must contain just lowercase, hyphens, and two characters at least."
    }
    validation {
        condition = can(
            regex(
                "([a-z-]{2,})",
                var.helm.prometheus-operator-crds.namespace
            )
        )
        error_message = "The namespace name must contain just owercase, hyphens, and two characters at least."
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