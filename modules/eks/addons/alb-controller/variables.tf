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
    repository  = "https://aws.github.io/eks-charts"
    chart       = "aws-load-balancer-controller"
  }
}

variable "cluster_name" {
  description = ""
  type        = string
  default     = ""
}

variable "openid" {
  description = ""
  type        = string
  default     = ""
}

variable "oidc_without_protocol" {
  description = ""
  type        = string
  default     = ""
}

variable "assume_role_policy" {
  description = ""
  type        = map(string)
  default = {
    namespace           = "kube-system"
    serviceAccountName  = "aws-load-balancer-controller"
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