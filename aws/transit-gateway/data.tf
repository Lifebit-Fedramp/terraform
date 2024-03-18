data "aws_region" "current" {}

data "aws_arn" "logs_bucket" {
  arn = var.flow_logs_bucket
}

data "aws_availability_zones" "this" {}


data "aws_caller_identity" "current" {}
