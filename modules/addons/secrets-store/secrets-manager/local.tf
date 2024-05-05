locals {
  news-aws-secrets-store = {
    name = lower("${var.prefix_name}-aws-secrets-manager-${var.tags["environment"]}")

    tolerations = {
      gpu = {
        key       = "nvidia.com/gpu"
        operator  = "Exists"
        effect    = "NoSchedule"
      }
      news_feed = {
        key       = "news/feed"
        operator  = "Exists"
        effect    = "NoSchedule"
      }
      news_system = {
        key       = "news/system"
        operator  = "Exists"
        effect    = "NoSchedule"
      }
    }
  }
}