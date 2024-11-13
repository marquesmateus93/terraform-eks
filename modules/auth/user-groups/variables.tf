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

variable "aws_auth" {
  description = "AWS Auth namespace."
  type        = object({
    name      = string
    namespace = string
    force     = bool
  })
  default     = {
    name      = "aws-auth"
    namespace = "kube-system"
    force     = true
  }
  validation {
    condition = (
      var.aws_auth.name == "aws-auth"
    )
    error_message = "ConfigMap name must to be 'aws-auth'."
  }
  validation {
    condition = (
      var.aws_auth.namespace == "kube-system"
    )
    error_message = "Namespace must to be 'kube-system'."
  }
  validation {
    condition = (
      var.aws_auth.force == true
    )
    error_message = "For must to be 'true' for aws-auth ConfigMap update."
  }
}

variable "custom_map_rules" {
  description = "Node Groups map roles."
  type = list(any)
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