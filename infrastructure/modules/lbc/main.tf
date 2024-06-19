# AWS Load Balancer Controller(LBC)
# Service Account Assume Role Policy
data "aws_iam_policy_document" "serviceaccount-assumerole" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(var.oidc_provider_url, "https://", "")}:sub"
      values   = ["system:serviceaccount:${var.lbc_namespace}:${var.lbc_sa}"]
    }

    condition {
      test     = "StringEquals"
      variable = "${replace(var.oidc_provider_url, "https://", "")}:aud"
      values   = ["sts.amazonaws.com"]
    }

    principals {
      identifiers = [var.oidc_provider_arn]
      type        = "Federated"
    }
  }
}

# IAM role for LBC service account
resource "aws_iam_role" "lbc" {
  name               = "${var.default_tags.Project}-${var.default_tags.Environment}-LBCRole"
  assume_role_policy = data.aws_iam_policy_document.serviceaccount-assumerole.json
}

resource "aws_iam_policy" "AWSLoadBalancerController" {
  name        = "${var.default_tags.Project}-${var.default_tags.Environment}-LBCPolicy"
  path        = "/"
  description = "AWS Load Balancer Controller(LBC) IAM Policy"
  policy      = file("./policies/AWSLoadBalancerControllerIAMPolicy.json")

}

resource "aws_iam_role_policy_attachment" "lbc-AWSLoadBalancerController" {
  policy_arn = aws_iam_policy.AWSLoadBalancerController.arn
  role       = aws_iam_role.lbc.name
}