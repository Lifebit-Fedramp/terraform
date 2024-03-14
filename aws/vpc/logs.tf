data "aws_iam_policy_document" "kms_vpc_flow_logs" {
  statement {
    sid = "vpc-flow-log-kms-policy-0"
    principals {
      type        = "AWS"
      identifiers = ["${data.aws_caller_identity.current.account_id}"]
    }

    actions   = ["*"]
    resources = ["*"]

  }

  statement {
    sid = "vpc-flow-log-kms-policy-1"

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
      values   = ["arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*"]
    }
  }

}

resource "aws_kms_key" "vpc_flow_logs" {
  description             = "KMS key to encrypt VPC flow logs"
  deletion_window_in_days = 7
  key_usage               = "ENCRYPT_DECRYPT"  
  tags = {
    Name = "${var.name}-vpc-flow-log-kms-key"
  }
}

resource "aws_kms_key_policy" "vpc_flow_logs_policy" {
  key_id = aws_kms_key.vpc_flow_logs.key_id
  policy = data.aws_iam_policy_document.kms_vpc_flow_logs.json
}

resource "aws_flow_log" "bucket" {
  log_destination      = var.flow_logs_bucket
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.main[0].id

  tags = {
    Name = "${var.name}-s3-flow-logs"
  }
}

resource "aws_flow_log" "cloudwatch" {
  iam_role_arn         = aws_iam_role.vpc_flow_logs.arn
  log_destination      = aws_cloudwatch_log_group.vpc_flow_logs.arn
  log_destination_type = "cloud-watch-logs"
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.main[0].id

  tags = {
    Name = "${var.name}-cloudwatch-flow-logs"
  }
}

resource "aws_cloudwatch_log_group" "vpc_flow_logs" {
  name              = "${var.name}-VPC-LOGS"
  retention_in_days = 365
  kms_key_id        = aws_kms_key.vpc_flow_logs.arn
}

resource "aws_cloudwatch_log_group" "network_firewall_flow_logs" {
  count             = var.enable_firewall == true ? 1 : 0
  name              = "${var.name}-NETWORK-FIREWALL-LOGS"
  retention_in_days = 365
  kms_key_id        = aws_kms_key.vpc_flow_logs.arn
}

resource "aws_iam_role" "vpc_flow_logs" {
  name = "${var.name}-VPC-LOGS"

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

resource "aws_iam_role_policy" "vpc_flow_logs" {
  name = "${var.name}-VPC-LOGS"
  role = aws_iam_role.vpc_flow_logs.id

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

resource "aws_networkfirewall_logging_configuration" "firewall" {
  count        = var.enable_firewall == true ? 1 : 0
  firewall_arn = aws_networkfirewall_firewall.firewall[0].arn
  logging_configuration {
    log_destination_config {
      log_destination = {
        bucketName = data.aws_arn.logs_bucket.resource
      }
      log_destination_type = "S3"
      log_type             = "ALERT"
    }
    log_destination_config {
      log_destination = {
        bucketName = data.aws_arn.logs_bucket.resource
      }
      log_destination_type = "S3"
      log_type             = "FLOW"
    }
  }
}
