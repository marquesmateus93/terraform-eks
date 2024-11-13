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

variable "helm" {
  description = "Helm chart properties."
  type        = object({
    repository  = string
    chart       = string
    namespace   = string
  })
  default = {
    repository  = "https://prometheus-community.github.io/helm-charts"
    chart       = "prometheus"
    namespace   = "prometheus"
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

variable "components" {
  description = "Prometheus components."
  type        = object({
    alertmanager            = bool
    kube-state-metrics      = bool
    prometheus-pushgateway  = bool
  })
  default = {
    alertmanager            = false
    kube-state-metrics      = false
    prometheus-pushgateway  = false
  }
  validation {
    condition = (
    var.components.alertmanager == true ||
    var.components.alertmanager == false
    )
    error_message = "The enable/disable flag must be 'true' or 'false'."
  }
  validation {
    condition = (
    var.components.kube-state-metrics == true ||
    var.components.kube-state-metrics == false
    )
    error_message = "The enable/disable flag must be 'true' or 'false'."
  }
  validation {
    condition = (
    var.components.prometheus-pushgateway == true ||
    var.components.prometheus-pushgateway == false
    )
    error_message = "The enable/disable flag must be 'true' or 'false'."
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

variable "internal-ingress" {
  description = "Internal ingress values."
  type        = object({
    target-type         = string
    scheme              = string
    ip-address-type     = string
  })
  default = {
    target-type         = "ip"
    scheme              = "internal"
    ip-address-type     = "ipv4"
  }
  validation {
    condition = (
      var.internal-ingress.target-type == "instance" ||
      var.internal-ingress.target-type == "ip"
    )
    error_message = "Choose 'instance' or 'ip'."
  }
  validation {
    condition = (
      var.internal-ingress.scheme == "internal" || 
      var.internal-ingress.scheme == "internet-facing"
    )
    error_message = "Choose 'internal' or 'internet-facing'."
  }
  validation {
    condition = (
      var.internal-ingress.ip-address-type == "ipv4"      ||
      var.internal-ingress.ip-address-type == "dualstack" || 
      var.internal-ingress.ip-address-type == "dualstack-without-public-ipv4"
    )
    error_message = "Choose 'ipv4' or  'dualstack' or 'dualstack-without-public-ipv4'."
  }
}

variable "subnets" {
    description = "Private subnets name or prefix."
    type        = list(string)
    default     = [
        "marques-vpc-private-subnet"
    ]
    validation {
        condition = alltrue([
            for item in var.subnets : can(
                regex(
                    "([a-z0-9-])",
                    item
                )
            )
        ])
    error_message = "The subnet name must contain just lowercase, numbers and hyphens."
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