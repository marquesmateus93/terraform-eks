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
    repository  = "https://kubernetes-sigs.github.io/aws-ebs-csi-driver"
    chart       = "aws-ebs-csi-driver"
    namespace   = "kube-system"
  }
}

variable "policies" {
  description = ""
  type        = list(string)
  default     =  [
    "AmazonEBSCSIDriverPolicy"
  ]
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
    serviceAccountName  = "ebs-csi-controller-sa"
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