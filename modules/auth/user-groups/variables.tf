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

variable "node-groups" {
  description = "Node groups ARNs."
  type        = object({
    general           = string
    behaviour-audio   = string
    behaviour-image   = string
    behaviour-video   = string
  })
  validation {
    condition = can(
      regex(
        "(arn:aws:iam::)([0-9]{12}:role)(\\/[A-Za-z-_]{1,64})",
        var.node-groups.general
      )
    )
    error_message = "The given value doesn't correspond an ARN."
  }
  validation {
    condition = can(
      regex(
        "(arn:aws:iam::)([0-9]{12}:role)(\\/[A-Za-z-_]{1,64})",
        var.node-groups.behaviour-audio
      )
    )
    error_message = "The given value doesn't correspond an ARN."
  }
  validation {
    condition = can(
      regex(
        "(arn:aws:iam::)([0-9]{12}:role)(\\/[A-Za-z-_]{1,64})",
        var.node-groups.behaviour-image
      )
    )
    error_message = "The given value doesn't correspond an ARN."
  }
  validation {
    condition = can(
      regex(
        "(arn:aws:iam::)([0-9]{12}:role)(\\/[A-Za-z-_]{1,64})",
        var.node-groups.behaviour-video
      )
    )
    error_message = "The given value doesn't correspond an ARN."
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