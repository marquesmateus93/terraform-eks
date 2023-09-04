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

variable "namespaces" {
  description = "Namespaces to br associated with Azure Pipeline authorizations."
  type        = list(string)
  validation {
    condition = alltrue ([
      for namespace in var.namespaces : can(
        regex(
          "([a-z-])", namespace
        )
      )
    ])
    error_message = "."
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