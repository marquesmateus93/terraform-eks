resource "aws_iam_policy" "alb-controller" {
  name        = local.policy_name
  description = "Policy body from GitHub document."
  policy      = data.http.alb-controller.response_body
}