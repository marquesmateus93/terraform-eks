variable "prefix_name" {
  description = "Resources prefix name."
  type        = string
  validation {
    condition = can(
      regex(
        "[[:lower:]]", var.prefix_name
      )
    )
    error_message = "Just lowercase, '_' and '-' are allowed."
  }
}

variable "eks_version" {
  description = "EKS version number."
  type        = string
  default     = "1.27"
  validation {
    condition = can(
      regex(
        "\\d{1,2}\\.\\d{1,2}", var.eks_version
      )
    )
    error_message = "EKS version is not valid. Fallow the pattern: XX.XX ."
  }
}

variable "policies" {
  description = "AWS suffix core policies names."
  type        = list(string)
  default     =  [
    "AmazonEKSClusterPolicy",
    "AmazonEKSVPCResourceController"
  ]
  validation {
    condition = alltrue([
      for item in var.policies : can(regex("[[:alpha:]]", item))
    ])
    error_message = "The given policy name doesn't exist in AWS."
  }
}

variable "api_endpoint" {
  description = "EKS API access configuration."
  type = object({
        public              = string
        private             = string
        public_access_cidrs = list(string)
  })
  default = {
    public               = "true"
    private              = "false"
    public_access_cidrs  = ["0.0.0.0/0"]
  }
  validation {
    condition = (
      var.api_endpoint.public == "true" ||
      var.api_endpoint.public == "false"
    )
    error_message = "Must be 'true' or 'false'."
  }
  validation {
    condition = (
      var.api_endpoint.private  == "true" ||
      var.api_endpoint.private  == "false"
    )
    error_message = "Must be 'true' or 'false'."
  }
  validation {
    condition = alltrue([
      for cidr in var.api_endpoint.public_access_cidrs : can(cidrnetmask(cidr))
    ])
    error_message = "Provide a list string of valid pattern: IPs/Mask."
  }
}

variable "log_types" {
  description = "EKS resources log levels."
  type        = list(string)
  default     = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]
  validation {
    condition = alltrue ([
      for type in var.log_types : contains(["api", "audit", "authenticator", "controllerManager", "scheduler"], type)
    ])
    error_message = "Must contain one of these arguments: 'api', 'audit', 'authenticator', 'controllerManager', 'scheduler'."
  }
}

variable "kubernetes_network_config" {
  description = "EKS network parameters."
  type        = object({
    service_ipv4_cidr = string
    ip_family         = string
  })
  default = {
    service_ipv4_cidr = "172.20.0.0/16"
    ip_family         = "ipv4"
  }
  validation {
    condition = (
      can(
        cidrnetmask(var.kubernetes_network_config.service_ipv4_cidr)
      )
    )
    error_message = "Provide a list string of valid pattern: IPs/Mask."
  }
  validation {
    condition = (
      var.kubernetes_network_config.ip_family == "ipv4" ||
      var.kubernetes_network_config.ip_family == "ipv6"
    )
    error_message = "Choose 'ipv4' or 'ipv6'."
  }
}

variable "tags" {
  description = "Tracking tags."
  type        = map(string)
  validation {
    condition = alltrue ([
      for tag in keys(var.tags) : contains(["environment", "creator_id", "powered_by"], tag)
    ])
    error_message = "Tags must contain at least: 'environment', 'creator_id' and 'powered_by'."
  }
}