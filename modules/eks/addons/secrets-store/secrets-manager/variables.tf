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
    repository  = "https://aws.github.io/secrets-store-csi-driver-provider-aws"
    chart       = "aws-secrets-manager"
    namespace   = "kube-system"
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