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
    repository            = string
    chart                 = string
    namespace             = string
  })
  default = {
    repository            = "https://aws.github.io/eks-charts"
    chart                 = "aws-load-balancer-controller"
    namespace             = "kube-system"
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

variable "cluster_name" {
  description = "News cluster name."
  type        = string
  validation {
    condition = (
      can(
        regex(
          "(marques)-(eks)-(dev|stg|prod)",
          var.cluster_name
        )
      )
    )
    error_message = "The given name doesn't match with the pattern name: news-eks-ENVIRONMENT"
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