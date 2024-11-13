# data "aws_iam_role" "administrator-role" {
#   name = "Administrator"
# }

data "aws_iam_roles" "administrator-sso-role" {
  name_regex = ".*administrator.*"
}

# data "aws_iam_role" "developers-role" {
#   name = "Developers"
# }

# data "aws_iam_role" "developer-role" {
#   name = "developer"
# }

data "aws_iam_roles" "readonly-sso-role" {
  name_regex = ".*readonly.*"
}