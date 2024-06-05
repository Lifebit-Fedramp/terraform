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
  name = "tenable"
  role = aws_iam_role.tenable.name
}

data "aws_iam_policy_document" "param_store" {

  statement {
    effect = "Allow"

    resources = [
      "${var.tenable_key_param_store}"
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

resource "aws_iam_role_policy_attachment" "ssm_manage_instance_core" {
  role       = aws_iam_role.tenable.name
  policy_arn = "arn:aws-us-gov:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
