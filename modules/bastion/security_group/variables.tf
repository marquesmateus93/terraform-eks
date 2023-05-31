variable "prefix_name" {
    description = ""
    type        = string
    validation {
      condition     = var.prefix_name != null
      error_message = "Input cannot be empty!"
    }
}

# Make some condition
variable "ports" {
  description  = ""
  type          = map(number)
  default = {
    ingress = 22
    egress  = 0
  }
}

# Make some condition
variable "cidrs" {
  description  = ""
  type          = map(string)
  default = {
    ipv4 = "0.0.0.0/0"
    ipv6 = "::/0"
  }
}

# Make some condition
variable "protocol" {
  description  = ""
  type          = map(string)
  default = {
    ingress = "tcp"
    egress = "-1"
  }
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