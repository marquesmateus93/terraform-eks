variable "prefix_name" {
    description = ""
    type        = string
    validation {
      condition     = var.prefix_name != null
      error_message = "Input cannot be empty!"
    }
}

variable "instance_type" {
    description = "Instance size"
    type        = string
    default     = "t2.micro"
}

variable "key_pair_name" {
    description = ""
    type        = string
    default     = ""
}

variable "is_bastion_enable" {
  description = "Bastion resource creation."
  type        = bool
  validation {
    condition = (
      var.is_bastion_enable == true ||
      var.is_bastion_enable == false
    )
    error_message = "The value must be 'true' or 'false'."
  }
}

variable "security_group_id" {
    description = ""
    type        = string
    default     = ""
}

variable "tags" {
  description = ""
  type        = map
  validation {
    condition = var.tags != null
    error_message = "Input cannot be empty!"
  }
}