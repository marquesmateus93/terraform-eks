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

variable "helm_service_monitors" {
  description = "Private Marques Helm Chart properties."
  type        = object({
    repository  = string
    chart       = string
  })
  default = {
    repository  = "oci://1286847858729367507.dkr.ecr.us-east-2.amazonaws.com"
    chart       = "marques-helm-service-monitors"
  }
  validation {
    condition = can(
      regex(
        "(oci:\\/\\/)([0-9]{12})(\\.dkr.ecr)(\\.(us(-gov)?|ap|ca|cn|eu|sa)-(central|(north|south)?(east|west)?)(-[0-5]{1})(\\.amazonaws.com))",
        var.helm_service_monitors.repository
      )
    )
    error_message = "Incorrect Helm Repository URL."
  }
  validation {
    condition = can(
      regex(
        "([a-z-]{2,})",
        var.helm_service_monitors.chart
      )
    )
    error_message = "Incorrect Helm Chart name."
  }
}

variable "helm_metagpu" {
  description = "Private Marques Helm Chart properties."
  type        = object({
    repository  = string
    chart       = string
    namespace   = string
  })
  default = {
    repository  = "oci://1286847858729367507.dkr.ecr.us-east-2.amazonaws.com"
    chart       = "marques-helm-metagpu"
    namespace   = "nvidia"
  }
  validation {
    condition = can(
      regex(
        "(oci:\\/\\/)([0-9]{12})(\\.dkr.ecr)(\\.(us(-gov)?|ap|ca|cn|eu|sa)-(central|(north|south)?(east|west)?)(-[0-5]{1})(\\.amazonaws.com))",
        var.helm_metagpu.repository
      )
    )
    error_message = "Incorrect Helm Repository URL."
  }
  validation {
    condition = can(
      regex(
        "([a-z-]{2,})",
        var.helm_metagpu.chart
      )
    )
    error_message = "Incorrect Helm Chart name."
  }
  validation {
    condition = (
      var.helm_metagpu.namespace == "nvidia"
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