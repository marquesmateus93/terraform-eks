locals {
  news-csi-helm = {
    name                  = "${var.prefix_name}-csi-${var.tags["environment"]}"
    service_account_name  = "${var.prefix_name}-csi-sa-${var.tags["environment"]}"

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

  news-csi-role = {
    name   = "${var.prefix_name}-csi-role-${var.tags["environment"]}"
  }
}