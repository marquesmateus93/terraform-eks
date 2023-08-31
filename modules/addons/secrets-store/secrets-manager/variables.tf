variable "prefix_name" {
  description = "Resources prefix name."
  type        = string
  validation {
    condition = can(
      regex(
        "[[:lower:]]", var.prefix_name
      )
    )
    error_message = "Just lowercase, '_' and '-' are allowed."
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
    repository  = "https://aws.github.io/secrets-store-csi-driver-provider-aws"
    chart       = "secrets-store-csi-driver-provider-aws"
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