data "http" "alb-controller-policy-json" {
  url = "https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.5.1/docs/install/iam_policy.json"

  request_headers = {
    Accept = "application/json"
  }
}