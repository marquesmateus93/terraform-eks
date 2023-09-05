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

variable "helm_iaris_service_monitors" {
  description = "Helm chart properties."
  type        = object({
    repository  = string
    chart       = string
  })
  default = {
    repository  = "oci://757477305767.dkr.ecr.us-east-2.amazonaws.com"
    chart       = "iaris-service-monitors"
  }
  validation {
    condition = can(
      regex(
        "(oci:\\/\\/)([0-9]{12})(\\.dkr.ecr)(\\.(us(-gov)?|ap|ca|cn|eu|sa)-(central|(north|south)?(east|west)?)(-[0-5]{1})(\\.amazonaws.com))",
        var.helm_iaris_service_monitors.repository
      )
    )
    error_message = "Incorrect Helm Repository URL."
  }
  validation {
    condition = can(
      regex(
        "([a-z-]{2,})",
        var.helm_iaris_service_monitors.chart
      )
    )
    error_message = "Incorrect Helm Chart name."
  }
}

variable "helm_iaris_metagpu" {
  description = "Helm chart properties."
  type        = object({
    repository  = string
    chart       = string
    namespace   = string
  })
  default = {
    repository  = "oci://757477305767.dkr.ecr.us-east-2.amazonaws.com"
    chart       = "iaris-metagpu"
    namespace   = "nvidia"
  }
  validation {
    condition = can(
      regex(
        "(oci:\\/\\/)([0-9]{12})(\\.dkr.ecr)(\\.(us(-gov)?|ap|ca|cn|eu|sa)-(central|(north|south)?(east|west)?)(-[0-5]{1})(\\.amazonaws.com))",
        var.helm_iaris_metagpu.repository
      )
    )
    error_message = "Incorrect Helm Repository URL."
  }
  validation {
    condition = can(
      regex(
        "([a-z-]{2,})",
        var.helm_iaris_metagpu.chart
      )
    )
    error_message = "Incorrect Helm Chart name."
  }
  validation {
    condition = (
      var.helm_iaris_metagpu.namespace == "cnvrg" ||
      var.helm_iaris_metagpu.namespace == "nvidia"
    )
    error_message = "Namespace must to be 'cnvrg' or 'nvidia'."
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