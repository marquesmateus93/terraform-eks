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
    repository  = string
    chart       = string
    namespace   = string
  })
  default = {
    repository  = "https://kubernetes-sigs.github.io/aws-ebs-csi-driver"
    chart       = "aws-ebs-csi-driver"
    namespace   = "kube-system"
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

variable "policies" {
  description = "AWS suffix core policies names."
  type        = list(string)
  default     =  [
    "AmazonEBSCSIDriverPolicy"
  ]
  validation {
    condition = alltrue([
      for item in var.policies : can(
        regex(
          "[A-Za-z]",
          item
        )
      )
    ])
    error_message = "Provide a valid AWS Policy name."
  }
}

variable "oidc_provider" {
  description = "OIDC ARN from Identity Provider(IAM)."
  type        = string
  validation {
    condition = can(
      regex(
        "(arn:aws:iam::)([0-9]{12})(:oidc-provider\\/)(oidc.eks.)(us(-gov)?|ap|ca|cn|eu|sa)-(central|(north|south)?(east|west)?)-\\d(.amazonaws.com\\/id\\/)([A-Z0-9]{32})",
        var.oidc_provider
      )
    )
    error_message = "The given value don't correspond to a ARN pattern."
  }
}

variable "oidc_without_protocol" {
  description = "EKS OpenID URL without HTTPS protocol."
  type        = string
  validation {
    condition = can(
      regex(
        "(oidc.eks)(\\.(us(-gov)?|ap|ca|cn|eu|sa)-(central|(north|south)?(east|west)?)-[1-5](.amazonaws.com\\/id)(\\/[A-Z0-9]{32}))",
        var.oidc_without_protocol
      )
    )
    error_message = "The given URL doesn't correspond to a AWS OIDC URL without the protocol at the begin."
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