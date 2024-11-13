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
    repository            = string
    chart                 = string
    namespace             = string
  })
  default = {
    repository            = "https://aws.github.io/eks-charts"
    chart                 = "aws-cloudwatch-metrics"
    namespace             = "cloudwatch-metrics"
  }
  validation {
    condition = can(
      regex(
        "(https:\\/\\/)?[a-zA-]{2,}(\\.[a-z]{2,})(\\.[a-z]{2,})(\\/[a-z-]{2,})?",
        var.helm.repository
      )
    )
    error_message = "The URL pattern not allowed."
  }
  validation {
    condition = can(
      regex(
        "([a-z-]{2,})",
        var.helm.chart
      )
    )
    error_message = "The chart name must contain just lowercase, hyphens, and two characters at least."
  }
  validation {
    condition = can(
      regex(
        "([a-z-]{2,})",
        var.helm.namespace
      )
    )
    error_message = "The namespace name must contain just owercase, hyphens, and two characters at least."
  }
}

variable "cluster_name" {
  description = "Cluster name."
  type        = string
  validation {
    condition = (
      can(
          regex(
          "^[0-9A-Za-z][A-Za-z0-9\\-_]*",
          var.cluster_name
        )
      )
    )
    error_message = "The cluster name must contain just letters, numbers, hyphens and underscores."
  }
  validation {
    condition = (
      length(var.cluster_name) <= 100
    )
    error_message = "Cluster name is oversized."
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