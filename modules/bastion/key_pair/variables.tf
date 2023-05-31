variable "prefix_name" {
    description = "Resources prefix name"
    type        = string
    validation {
      condition     = var.prefix_name != null
      error_message = "Input cannot be empty!"
    }
}

variable "public_key" {
    description = ""
    type        = string
    # validation {
    #   condition     = can(regex("ssh-rsa AAAA[0-9A-Za-z+/]+[=]{0,3} ([^@]+@[^@]+)",
    #                   var.ssh_public_key))
    #   error_message = "The value must be a valid SSH public key!"
    # }
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

variable "tags" {
  description = ""
  type        = map
  validation {
    condition = var.tags != null
    error_message = "Input cannot be empty!"
  }
}