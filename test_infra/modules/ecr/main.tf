# Private ECR Repository
resource "aws_ecr_repository" "image" {
  name         = "image-repo"
  force_delete = true
}

resource "aws_ecr_repository" "chart" {
  name         = "chart-repo"
  force_delete = true
}

# Github actions role (push image and chart to ECR)
data "aws_iam_policy_document" "ga-assumerole" {
  statement {
    actions = [
      "sts:AssumeRole",
      "sts:TagSession"
    ]
    effect  = "Allow"

    principals {
      type        = "AWS"
      identifiers = [var.github_account_id]
    }
  }
}

# ECR Push Assume Role Policy
data "aws_iam_policy_document" "ecr-push" {
  statement {
    actions = [
      "ecr:CompleteLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:InitiateLayerUpload",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage"
    ]
    effect = "Allow"
    resources = [
      aws_ecr_repository.image.arn,
      aws_ecr_repository.chart.arn
    ]
  }

  statement {
    actions   = ["ecr:GetAuthorizationToken"]
    effect    = "Allow"
    resources = ["*"]
  }
}

resource "aws_iam_role" "github-actions" {
  name               = "GithubActionsRole"
  assume_role_policy = data.aws_iam_policy_document.ga-assumerole.json
  inline_policy {
    name   = "ecr-push"
    policy = data.aws_iam_policy_document.ecr-push.json
  }
}