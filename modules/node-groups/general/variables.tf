variable "prefix_name" {
  description = "Resources prefix name."
  type        = string
  validation {
    condition = can(
      regex(
        "[a-z-]",
        var.prefix_name
      )
    )
    error_message = "The prefix name must contain just lowercase and hyphens."
  }
}

variable "cluster_name" {
  description = "Cluster name."
  type        = string
  validation {
    condition = (
      can(
          regex(
          "^[0-9A-Za-z][A-Za-z0-9\\-_]*",
          var.cluster_name
        )
      )
    )
    error_message = "The cluster name must contain just letters, numbers, hyphens and underscores."
  }
  validation {
    condition = (
      length(var.cluster_name) <= 100
    )
    error_message = "Cluster name is oversized."
  }
}

variable "eks_version" {
  description = "EKS version number."
  type        = string
  default     = "1.27"
  validation {
    condition = can(
      regex(
        "\\d{1,2}\\.\\d{1,2}",
        var.eks_version
      )
    )
    error_message = "Provide a valid EKS version. The pattern is: XX.XX ."
  }
}

variable "ami_type" {
  description = "AMI instance type."
  type        = string
  default     = "AL2_x86_64"
  validation {
    condition = (
      var.ami_type == "AL2_x86_64"
    )
    error_message = "Provide a valid CPU AMI type."
  }
}

variable "capacity_type" {
  description = "value"
  type        = string
  default     = "ON_DEMAND"
  validation {
    condition = anytrue([
      var.capacity_type == "ON_DEMAND",
      var.capacity_type == "SPOT"
    ])
    error_message = "Choose 'ON_DEMAND' or 'SPOT'."
  }
}

variable "instance_types" {
  description = "CPU instance types to be launched."
  type        = object({
    non_production  = list(string)
    production      = list(string)
  })
  default = {
    non_production  = ["t3.micro"]
    production      = ["t3.micro"]
  }
  validation {
    condition = alltrue([
      for item in var.instance_types.non_production : can(
        regex(
          "((a1|c1|c3|c4|c5|c5a|c5ad|c5d|c5n|c6a|c6g|c6gd|c6gn|c6i|c6id|c7g|cc2|d2|d3|d3en|dl1|f1|g2|g3|g3s|g4ad|g4dn|g5|g5g|h1|i2|i3|i3en|i4i|im4gn|inf1|is4gen|m1|m2|m3|m4|m5|m5a|m5ad|m5d|m5dn|m5n|m5zn|m6a|m6g|m6gd|m6i|m6id|mac1|mac2|p2|p3|p3dn|p4d|r3|r4|r5|r5a|r5ad|r5b|r5d|r5dn|r5n|r6a|r6g|r6gd|r6i|r6id|t1|t2|t3|t3a|t4g|trn1|u-12tb1|u-3tb1|u-6tb1|u-9tb1|vt1|x1|x1e|x2gd|x2idn|x2iedn|x2iezn|z1d)\\.(10xlarge|112xlarge|12xlarge|16xlarge|18xlarge|24xlarge|2xlarge|32xlarge|3xlarge|48xlarge|4xlarge|56xlarge|6xlarge|8xlarge|9xlarge|large|medium|metal|micro|nano|small|xlarge))",
          item
        )
      )
    ])
    error_message = "Provide a valid AWS instance type."
  }
  validation {
    condition = alltrue([
      for item in var.instance_types.production : can(
        regex(
        "((a1|c1|c3|c4|c5|c5a|c5ad|c5d|c5n|c6a|c6g|c6gd|c6gn|c6i|c6id|c7g|cc2|d2|d3|d3en|dl1|f1|g2|g3|g3s|g4ad|g4dn|g5|g5g|h1|i2|i3|i3en|i4i|im4gn|inf1|is4gen|m1|m2|m3|m4|m5|m5a|m5ad|m5d|m5dn|m5n|m5zn|m6a|m6g|m6gd|m6i|m6id|mac1|mac2|p2|p3|p3dn|p4d|r3|r4|r5|r5a|r5ad|r5b|r5d|r5dn|r5n|r6a|r6g|r6gd|r6i|r6id|t1|t2|t3|t3a|t4g|trn1|u-12tb1|u-3tb1|u-6tb1|u-9tb1|vt1|x1|x1e|x2gd|x2idn|x2iedn|x2iezn|z1d)\\.(10xlarge|112xlarge|12xlarge|16xlarge|18xlarge|24xlarge|2xlarge|32xlarge|3xlarge|48xlarge|4xlarge|56xlarge|6xlarge|8xlarge|9xlarge|large|medium|metal|micro|nano|small|xlarge))",
          item
        )
      )
    ])
    error_message = "Provide a valid AWS instance type."
  }
}

variable "disk_space" {
  description = "Node group disk size instance."
  type        = string
  default     = "80"
  validation {
    condition = (
      contains([
        "40", "60", "80", "100", "200"
        ], var.disk_space
      )
    )
    error_message = "Choose one of the disk size values: 40, 60, 80, 100 or 200."
  }
}

variable "scaling_config" {
  description = "Scale up and down parameters."
  type        = object({
    desired_size = string
    max_size     = string
    min_size     = string
  })
  default = {
    desired_size = "0"
    max_size     = "1"
    min_size     = "0"
  }
  validation {
    condition = (
      can(
        regex(
          "[0-9]",
          var.scaling_config.desired_size
        )
      )
    )
    error_message = "Provide a value between 0 and 9."
  }
  validation {
    condition = (
      can(
        regex(
          "[1-9]",
          var.scaling_config.max_size
        )
      )
    )
    error_message = "Provide a value between 1 and 9."
  }
  validation {
    condition = (
      can(
        regex(
          "[0-9]",
          var.scaling_config.min_size
        )
      )
    )
    error_message = "Provide a value between 0 and 9."
  }
}

variable "max_unavailable" {
  description = "Maximum number of unavailable instances."
  type        = string
  default     = "1"
  validation {
    condition = (
      can(
        regex(
          "[0-9]",
          var.max_unavailable
        )
      )
    )
    error_message = "Provide a value between 0 and 9."
  }
}

variable "subnets" {
  description = "Private subnets name or prefix."
  type        = list(string)
  default     = []
  validation {
    condition = alltrue([
      for item in var.subnets : can(
        regex(
          "([a-z0-9-])",
          item
        )
      )
    ])
    error_message = "The subnet name must contain just lowercase, numbers and hyphens."
  }
}

variable "policies" {
  description = "AWS suffix core policies names."
  type        = list(string)
  default     = [
    "AmazonEKSWorkerNodePolicy",
    "AmazonEKS_CNI_Policy",
    "AmazonEC2ContainerRegistryReadOnly"
  ]
  validation {
    condition = alltrue([
      for item in var.policies : can(
        regex(
          "[A-Za-z]",
          item
        )
      )
    ])
    error_message = "Provide a valid AWS Policy name."
  }
}

variable "tags" {
  description = "Tracking tags."
  type        = map(string)
  validation {
    condition = alltrue ([
      for tag in keys(var.tags) : contains([
          "environment",
          "creator_id",
          "powered_by"
        ],tag
      )
    ])
    error_message = "Tags must contain at least: 'environment', 'creator_id' and 'powered_by'."
  }
}