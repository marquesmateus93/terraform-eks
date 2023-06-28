variable "prefix_name" {
  description = ""
  type        = string
  validation {
    condition     = var.prefix_name != null
    error_message = "Input cannot be empty!"
  }
}

variable "helm" {
  description = ""
  type        = map(string)
  default     = {
    repository  = "https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts"
    chart       = "secrets-store-csi-driver"
    namespace   = "default"
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