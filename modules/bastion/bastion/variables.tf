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

variable "security_group_name" {
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