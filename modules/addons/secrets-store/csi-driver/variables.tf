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
    error_message = "The Prefix Name must contain just lowercase and hyphens."
  }
}

variable "is_enabled" {
  description = "Deploy the resource or not."
  type        = bool
  default     = true
  validation {
    condition = (
      var.is_enabled == true ||
      var.is_enabled == false
    )
    error_message = "Must be 'true' or 'false'."
  }
}

variable "helm" {
  description = "Helm chart properties."
  type        = object({
    repository  = string
    chart       = string
    namespace   = string
  })
  default = {
    repository  = "https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts"
    chart       = "secrets-store-csi-driver"
    namespace   = "kube-system"
  }
  validation {
    condition = can(
      regex(
        "(https:\\/\\/)?[a-zA-]{2,}(\\.[a-z]{2,})(\\.[a-z]{2,})(\\/[a-z-]{2,})?",
        var.helm.repository
      )
    )
    error_message = "Incorrect Helm Repository URL."
  }
  validation {
    condition = can(
      regex(
        "([a-z-]{2,})",
        var.helm.chart
      )
    )
    error_message = "Incorrect Helm Chart name."
  }
  validation {
    condition = (
    var.helm.namespace == "kube-system"
    )
    error_message = "Namespace must to be 'kube-system'."
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