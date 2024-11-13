resource "aws_iam_role" "cluster-autoscaler-role" {
  name                = local.cluster-autoscaler-role.name
  assume_role_policy = jsonencode({
    "Version" = "2012-10-17",
    "Statement" = [{
      "Effect" = "Allow",
      "Action" = [
        "sts:AssumeRoleWithWebIdentity"
      ],
      "Principal" = {
        "Federated" = var.oidc_provider
      },
      "Condition" : {
        "StringEquals" : {
          "${var.oidc_without_protocol}:sub" = "system:serviceaccount:${var.helm.namespace}:${local.cluster-autoscaler-role.service_account_name}",
          "${var.oidc_without_protocol}:aud" = "sts.amazonaws.com"
        }
      }
    }]
  })

  tags = merge({Name = local.cluster-autoscaler-role.name},
              var.tags)
}

resource "aws_iam_role_policy" "cluster-autoscaler-role-policy" {
  name = local.cluster-autoscaler-role.name
  role   = aws_iam_role.cluster-autoscaler-role.id
  policy = jsonencode({
    "Version": "2012-10-17"
    "Statement" = [{
      "Effect" = "Allow"
      "Action" = [
        "autoscaling:DescribeAutoScalingGroups",
        "autoscaling:DescribeAutoScalingInstances",
        "autoscaling:DescribeLaunchConfigurations",
        "autoscaling:DescribeScalingActivities",
        "autoscaling:DescribeTags",
        "ec2:DescribeInstanceTypes",
        "ec2:DescribeLaunchTemplateVersions"
      ]
      "Resource" = "*"
    },
    {
      "Effect" = "Allow"
      "Action" = [
        "autoscaling:SetDesiredCapacity",
        "autoscaling:TerminateInstanceInAutoScalingGroup",
        "ec2:DescribeImages",
        "ec2:GetInstanceTypesFromInstanceRequirements",
        "eks:DescribeNodegroup"
      ]
      "Resource" = "*"
    }]
  })
  depends_on = [
    aws_iam_role.cluster-autoscaler-role
  ]
}