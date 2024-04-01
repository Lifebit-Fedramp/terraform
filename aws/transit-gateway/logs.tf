data "aws_iam_policy_document" "kms_tgw_flow_logs" {
  statement {
    sid = "tgw-flow-log-kms-policy-0"
    principals {
      type        = "AWS"
      identifiers = ["${data.aws_caller_identity.current.account_id}"]
    }

    actions   = ["kms:*"]
    resources = ["*"]

  }

  statement {
    sid = "tgw-flow-log-kms-policy-1"

    actions = [
      "kms:Encrypt*",
      "kms:Decrypt*",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:Describe*"
    ]

    principals {
      type        = "Service"
      identifiers = ["logs.${data.aws_region.current.name}.amazonaws.com"]
    }

    resources = ["*"]

    condition {
      test     = "ArnLike"
      variable = "kms:EncryptionContext:aws:logs:arn"
      values   = ["arn:aws-us-gov:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*"]
    }
  }

}

resource "aws_kms_key" "tgw_flow_logs" {
  description             = "KMS key to encrypt transit gateway flow logs"
  deletion_window_in_days = 7
  key_usage               = "ENCRYPT_DECRYPT"
  tags = {
    Name = "${var.name}-tgw-flow-log-kms-key"
  }

  policy = data.aws_iam_policy_document.kms_tgw_flow_logs.json
}

resource "aws_flow_log" "bucket" {
  log_destination          = var.flow_logs_bucket
  log_destination_type     = "s3"
  traffic_type             = "ALL"
  transit_gateway_id       = aws_ec2_transit_gateway.tgw.id
  max_aggregation_interval = 60

  tags = {
    Name = "${var.name}-s3-flow-logs"
  }
}


resource "aws_flow_log" "tgw_cloudwatch" {
  iam_role_arn             = aws_iam_role.tgw_flow_logs.arn
  log_destination          = aws_cloudwatch_log_group.tgw_flow_logs.arn
  log_destination_type     = "cloud-watch-logs"
  traffic_type             = "ALL"
  transit_gateway_id       = aws_ec2_transit_gateway.tgw.id
  max_aggregation_interval = 60

  tags = {
    Name = "${var.name}-tgw-cloudwatch-flow-logs"
  }
}

resource "aws_cloudwatch_log_group" "tgw_flow_logs" {
  name              = "${var.name}-TGW-LOGS"
  retention_in_days = 365
  kms_key_id        = aws_kms_key.tgw_flow_logs.arn
}

resource "aws_iam_role" "tgw_flow_logs" {
  name = "${var.name}-TGW-LOGS"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "tgw_flow_logs" {
  name = "${var.name}-TGW-LOGS"
  role = aws_iam_role.tgw_flow_logs.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}