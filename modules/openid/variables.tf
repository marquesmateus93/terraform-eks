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
    error_message = "Value doesn't match with OIDC URL pattern."
  }
}

variable "oidc_without_protocol" {
  description = "Same OIDC EKS URL without 'https://' at begging."
  type        = string
  validation {
    condition     = can(
      regex(
        "(oidc)(\\.eks)(\\.(us(-gov)?|ap|ca|cn|eu|sa)-(central|(north|south)?(east|west)?)-([1-5]))(\\.amazonaws)(\\.com)(\\/id\\/)([A-Z0-9]{32})",
        var.oidc_without_protocol
      )
    )
    error_message = "Value doesn't match with OIDC URL no protocol pattern."
  }
}

variable "thumbprint_list" {
  description = "EKS cluster thumbprint."
  type        = list(string)
  validation {
    condition = alltrue([
      for item in var.thumbprint_list : can(regex("([a-z0-9]{40})", item))
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
      for item in var.policies : can(regex("[A-Za-z0-9-]", item))
    ])
    error_message = "Just letters and numbers are allowed."
  }
  validation {
    condition = (
      length(var.policies) <= 128
    )
    error_message = "The policy size name must be shorter or equal to 128."
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