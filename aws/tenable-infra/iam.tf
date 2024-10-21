data "aws_iam_policy_document" "tenable" {
  statement {
    sid = ""

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    effect = "Allow"
  }
}

resource "aws_iam_role" "tenable" {
  name               = "tenable"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.tenable.json
  tags = {
    Name = "tenable"
  }
}

resource "aws_iam_instance_profile" "tenable" {
  name = "${var.tenable_install_type}_tenable"
  role = aws_iam_role.tenable.name
}

data "aws_iam_policy_document" "param_store" {

  statement {
    effect = "Allow"

    resources = [
      "${var.tenable_key_param_store}",
      "${var.tenable_was_name_parm_store}"
    ]

    actions = [
      "ssm:GetParameters"
    ]
  }
}

resource "aws_iam_role_policy" "tenable_param_store" {
  name   = "tenable-param-store"
  role   = aws_iam_role.tenable.id
  policy = data.aws_iam_policy_document.param_store.json
}

data "aws_iam_policy_document" "tenable_ecr_pull" {

  statement {
    effect = "Allow"

    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetRepositoryPolicy",
      "ecr:DescribeRepositories",
      "ecr:ListImages",
      "ecr:BatchGetImage"
    ]

    resources = [
      "${var.tenable_was_ecr_repo}"
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "ecr:GetAuthorizationToken"
    ]

    resources = ["*"]

  }
}

resource "aws_iam_role_policy" "tenable_ecr_pull" {
  name   = "tenable-ecr-pull"
  role   = aws_iam_role.tenable.id
  policy = data.aws_iam_policy_document.tenable_ecr_pull.json
}

resource "aws_iam_role_policy_attachment" "ssm_manage_instance_core" {
  role       = aws_iam_role.tenable.name
  policy_arn = "arn:aws-us-gov:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "cloudwatch_agent_server_policy" {
  role       = aws_iam_role.tenable.name
  policy_arn = "arn:aws-us-gov:iam::aws:policy/CloudWatchAgentServerPolicy"
}

data "aws_iam_policy_document" "cloudwatch_log_retention" {

  statement {
    effect = "Allow"

    actions = [
      "logs:PutRetentionPolicy"
    ]

    resources = [
      "arn:aws-us-gov:logs:${data.aws_region.current.id}:${data.aws_caller_identity.current.id}:*"
    ]
  }
}

resource "aws_iam_role_policy" "cloudwatch_log_retention" {
  name   = "tenable-cloudwatch-set-log-retention"
  role   = aws_iam_role.tenable.id
  policy = data.aws_iam_policy_document.cloudwatch_log_retention.json
}