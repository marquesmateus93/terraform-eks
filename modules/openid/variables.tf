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

variable "oidc" {
  description = "OIDC EKS URL."
  type        = string
  validation {
    condition = can(
      regex(
        "(https:\\/\\/)(oidc)(\\.eks)(\\.(us(-gov)?|ap|ca|cn|eu|sa)-(central|(north|south)?(east|west)?)-([1-5]))(\\.amazonaws)(\\.com)(\\/id\\/)([A-Z0-9]{32})",
        var.oidc
      )
    )
    error_message = "The given value don't correspond to a ARN pattern."
  }
}

variable "oidc_without_protocol" {
  description = "Same OIDC EKS URL without 'https://' from begging."
  type        = string
  validation {
    condition = can(
      regex(
        "(oidc)(\\.eks)(\\.(us(-gov)?|ap|ca|cn|eu|sa)-(central|(north|south)?(east|west)?)-([1-5]))(\\.amazonaws)(\\.com)(\\/id\\/)([A-Z0-9]{32})",
        var.oidc_without_protocol
      )
    )
    error_message = "The given URL doesn't correspond to a AWS OIDC URL without the protocol at the begin."
  }
}

variable "thumbprint_list" {
  description = "EKS cluster thumbprint."
  type        = list(string)
  validation {
    condition = alltrue([
      for item in var.thumbprint_list : can(
        regex(
          "([a-z0-9]{40})",
          item
        )
      )
    ])
    error_message = "String doesn't match with thumbprint pattern."
  }
}

variable "policies" {
  description = "AWS suffix policies names."
  type        = list(string)
  default     =  [
    "AmazonS3ReadOnlyAccess"
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

variable "tags" {
  description = "Tracking tags."
  type        = map(string)
  validation {
    condition = alltrue ([
      for tag in keys(var.tags) : contains([
          "environment",
          "creator_id",
          "powered_by"
        ],tag
      )
    ])
    error_message = "Tags must contain at least: 'environment', 'creator_id' and 'powered_by'."
  }
}