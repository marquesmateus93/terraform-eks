variable "prefix_name" {
  description = ""
  type        = string
  validation {
    condition     = var.prefix_name != null
    error_message = "Input cannot be empty!"
  }
}

variable "cluster_name" {
  description = ""
  type        = string
  validation {
    condition = var.cluster_name != null
    error_message = "Input cannot be empty!"
  }
}

variable "ami_type" {
  description = "value"
  type        = string
  default     = "AL2_x86_64"
}

variable "eks_version" {
  description = ""
  type        = string
  default     = ""
}

variable "capacity_type" {
  description = "value"
  type        = string
  default     = "SPOT"
  validation {
    condition = anytrue([
      var.capacity_type == "ON_DEMAND",
      var.capacity_type == "SPOT"
    ])
    error_message = "Invalid input. Choose 'ON_DEMAND' or 'SPOT'"
  }
}

variable "instance_types" {
  description = ""
  type        = map(string)
  default     = {
    dev = "t3.medium"
  }
}

variable "ec2_ssh_key" {
  description = ""
  type        = string
  default     = ""
}

variable "scaling_config" {
  description = ""
  type        = map(string)
  default     = {
      desired_size = "1"
      max_size     = "2"
      min_size     = "1"
  }
}

variable "max_unavailable" {
  description = ""
  type        = string
  default     = "1"
}

variable "policies" {
  description = ""
  type        = list(string)
  default     = [
    "AmazonEKSWorkerNodePolicy",
    "AmazonEKS_CNI_Policy",
    "AmazonEC2ContainerRegistryReadOnly"
  ]
}

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

variable "security_groups" {
  description = ""
  type        = string
  default     = ""
}

variable "tags" {
  description = ""
  type        = map(string)
  validation {
    condition = var.tags != null
    error_message = "Input cannot be empty!"
  }
}