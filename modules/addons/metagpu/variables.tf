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
  description = "GPU Helm packages."
  type = object({
    service_monitors = object({
      repository  = string
      chart       = string
      namespace   = string
    })
    metagpu = object({
      repository  = string
      chart       = string
      namespace   = string
    })
  })

  validation {
    condition = can(
      regex(
        "(https:\\/\\/)?[a-zA-]{2,}(\\.[a-z]{2,})(\\.[a-z]{2,})(\\/[a-z-]{2,})?",
        var.helm.service_monitors.repository
      )
    )
    error_message = "The URL pattern not allowed."
  }
  validation {
    condition = can(
      regex(
        "([a-z-]{2,})",
        var.helm.service_monitors.chart
      )
    )
    error_message = "The chart name must contain just lowercase, hyphens, and two characters at least."
  }
  validation {
    condition = (
      var.helm.service_monitors.namespace == "nvidia"
    )
    error_message = "Namespace must to be 'nvidia'."
  }
  validation {
    condition = can(
      regex(
        "(https:\\/\\/)?[a-zA-]{2,}(\\.[a-z]{2,})(\\.[a-z]{2,})(\\/[a-z-]{2,})?",
        var.helm.metagpu.repository
      )
    )
    error_message = "The URL pattern not allowed."
  }
  validation {
    condition = can(
      regex(
        "([a-z-]{2,})",
        var.helm.metagpu.chart
      )
    )
    error_message = "The chart name must contain just lowercase, hyphens, and two characters at least."
  }
  validation {
    condition = (
      var.helm.metagpu.namespace == "nvidia"
    )
    error_message = "Namespace must to be 'nvidia'."
  }
}

variable "tags" {
  description = "Tracking tags."
  type        = map(string)
  validation {
    condition = alltrue ([
      for tag in keys(var.tags) : contains(["environment", "creator_id", "powered_by"], tag)
    ])
    error_message = "Tags must contain at least: 'environment', 'creator_id' and 'powered_by'."
  }
}