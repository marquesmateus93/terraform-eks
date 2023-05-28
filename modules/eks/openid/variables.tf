variable "prefix_name" {
  description = ""
  type        = string
  validation {
    condition     = var.prefix_name != null
    error_message = "Input cannot be empty!"
  }
}

variable "oidc" {
  description = ""
  type        = string
  default     = ""
  validation {
    condition     = var.oidc != null
    error_message = "Input cannot be empty!"
  }
}

variable "oidc_without_protocol" {
  description = ""
  type        = string
  default     = ""
}

variable "thumbprint_list" {
  description = ""
  type        = string
  default     = ""
  validation {
    condition     = var.thumbprint_list != null
    error_message = "Input cannot be empty!"
  }
}

variable "policies" {
  description = ""
  type        = list(string)
  default     =  [
    "AmazonS3ReadOnlyAccess"
  ]
}

variable "account_id" {
  description = ""
  type        = string
  default     = ""
  validation {
    condition     = var.account_id != null
    error_message = "Input cannot be empty!"
  }
}

variable "tags" {
  description = ""
  type        = map(string)
  validation {
    condition = var.tags != null
    error_message = "Input cannot be empty!"
  }
}