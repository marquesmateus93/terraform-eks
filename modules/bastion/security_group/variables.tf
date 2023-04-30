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

variable "tags" {
  description = ""
  type        = map
  validation {
    condition = var.tags != null
    error_message = "Input cannot be empty!"
  }
}