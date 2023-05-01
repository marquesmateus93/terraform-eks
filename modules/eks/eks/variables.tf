variable "prefix_name" {
  description = ""
  type        = string
  validation {
    condition     = var.prefix_name != null
    error_message = "Input cannot be empty!"
  }
}

variable "eks_version" {
  description = ""
  type        = string
  default     = "1.26"
}

variable "policies" {
  description = ""
  type        = list(string)
  default     =  [
    "AmazonEKSClusterPolicy",
    "AmazonEKSVPCResourceController"
  ]
}

variable "api_endpoint" {
    description = ""
    type        = map(string)
    default = {
      "private"             = "false"
      "public"              = "true"
      "public_access_cidrs" = "0.0.0.0/0"
    }
}

variable "log_types" {
  description = ""
  type        = list(string)
  default     = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]
}

variable "kubernetes_network_config" {
  description = ""
  type        = map(string)
  default = {
    "service_ipv4_cidr" = "172.20.0.0/16"
    "ip_family"         = "ipv4"
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