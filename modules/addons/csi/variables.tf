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

variable "policies" {
  description = "AWS suffix core policies names."
  type        = list(string)
  default     =  [
    "AmazonEBSCSIDriverPolicy"
  ]
  validation {
    condition = alltrue([
      for item in var.policies : can(regex("[[:alpha:]]", item))
    ])
    error_message = "The given policy name doesn't exist in AWS."
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
    error_message = "The given URL is not a valid EKS OpenID URL."
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
    error_message = "The given URL is not a valid EKS OpenID URL without HTTPS protocol."
  }
}

#variable "assume_role_policy" {
#  description = ""
#  type        = map(string)
#  default = {
#    namespace           = "kube-system"
#    serviceAccountName  = "ebs-csi-controller-sa"
#  }
#}

variable "assume_role_policy" {
  description = "CSI needed policies."
  type        = string
  default     = "ebs-csi-controller-sa"
  validation {
    condition = can(
      regex(
        "([a-z-])", var.assume_role_policy
      )
    )
    error_message = "Invalid policy pattern name. Just lowercase(a-z) and hifen(-). "
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