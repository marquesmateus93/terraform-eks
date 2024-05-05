data "aws_iam_role" "news-administrator-role" {
  name = "administrators"
}

data "aws_iam_roles" "news-administrator-sso-role" {
  name_regex  = "AWSReservedSSO_administrator"
}