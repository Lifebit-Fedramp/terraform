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
}

resource "aws_cloudwatch_log_group" "network_firewall_flow_logs" {
  count             = var.enable_firewall == true ? 1 : 0
  name              = "${var.name}-NETWORK-FIREWALL-LOGS"
  retention_in_days = 365
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
