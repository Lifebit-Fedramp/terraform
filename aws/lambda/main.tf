data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_iam_policy_document" "lambda_trust_policy" {
  version = "2012-10-17"
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

module "lambda_function" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "4.16.0"

  function_name               = var.function_name
  description                 = var.description
  handler                     = "${var.handler_file}.${var.handler_function}"
  runtime                     = var.runtime
  memory_size                 = var.memory_size
  timeout                     = var.timeout
  lambda_function_kms_key_arn = module.lambda_kms_key.key_arn
  environment_variables       = var.environment_variables

  create_package = false
  s3_existing_package = {
    bucket = var.s3_bucket
    key    = "${var.function_name}.zip"
  }

  # IAM fields
  create_role            = true
  attach_policies        = length(var.policies) > 0 || length(var.policy_jsons) > 0 ? true : false
  number_of_policies     = length(var.policies)
  policies               = var.policies
  number_of_policy_jsons = length(var.policy_jsons)
  policy_jsons           = var.policy_jsons

  # Cloudwatch config
  cloudwatch_logs_kms_key_id        = module.lambda_kms_key.key_arn
  cloudwatch_logs_retention_in_days = 30
  use_existing_cloudwatch_log_group = false

  # VPC fields
  vpc_subnet_ids         = var.vpc_subnet_ids
  vpc_security_group_ids = var.vpc_security_group_ids
}

module "lambda_kms_key" {
  source  = "terraform-aws-modules/kms/aws"
  version = "1.5.0"

  description = "lambda kms key"
  key_usage   = "ENCRYPT_DECRYPT"

  enable_key_rotation = true

  # Policy
  key_administrators = [data.aws_caller_identity.current.arn]
}


# Lambda Health Monitoring

resource "aws_cloudwatch_log_metric_filter" "error_log_metric_filter" {
  count          = var.health_monitor_sns_topic != "" ? 1 : 0
  name           = "${var.function_name}-lambda-error-filter"
  log_group_name = module.lambda_function.lambda_cloudwatch_log_group_name
  pattern        = var.health_monitor_log_level

  metric_transformation {
    name          = "lambda-${var.function_name}-errors-handled-exceptions"
    namespace     = "lambda-handled-exceptions"
    value         = "1"
    default_value = "0"
  }
}

resource "aws_cloudwatch_metric_alarm" "lambda-alarm-handled-exceptions" {
  count               = var.health_monitor_sns_topic != "" ? 1 : 0
  alarm_name          = "${var.function_name}-handled-exceptions"
  alarm_actions       = ["arn:aws:sns:us-east-1:${data.aws_caller_identity.current.account_id}:${var.health_monitor_sns_topic}"]
  dimensions          = { "FunctionName" : module.lambda_function.function_name }
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = aws_cloudwatch_log_metric_filter.error_log_metric_filter.metric_transformation[0].name
  namespace           = aws_cloudwatch_log_metric_filter.error_log_metric_filter.metric_transformation[0].namespace
  period              = "300"
  statistic           = "Sum"
  threshold           = "0"
  alarm_description   = "Standard alarm for lambda health monitoring, alert on unhandled errors"
  treat_missing_data  = "notBreaching"
}

resource "aws_cloudwatch_metric_alarm" "lambda-alarm-unhandled-exceptions" {
  count               = var.health_monitor_sns_topic != "" ? 1 : 0
  alarm_name          = "${var.function_name}-unhandled-exceptions"
  alarm_actions       = ["arn:aws:sns:us-east-1:${data.aws_caller_identity.current.account_id}:${var.health_monitor_sns_topic}}"]
  dimensions          = { "FunctionName" : module.lambda_function.function_name }
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "Errors"
  namespace           = "AWS/Lambda"
  period              = "300"
  statistic           = "Sum"
  threshold           = "0"
  alarm_description   = "Standard alarm for lambda health monitoring, alert on unhandled errors"
  treat_missing_data  = "notBreaching"
}

# Lambda Trigger Invocation on timed schedule

resource "aws_cloudwatch_event_rule" "lambda_schedule_rule" {
  count               = var.trigger_lambda_by_schedule == true ? 1 : 0
  name                = "${var.function_name}_schedule"
  description         = var.lambda_schedule_description
  schedule_expression = var.schedule_expression
}

resource "aws_cloudwatch_event_target" "lambda_schedule_target" {
  count = var.trigger_lambda_by_schedule == true ? 1 : 0
  rule  = aws_cloudwatch_event_rule.lambda_schedule_rule[0].name
  arn   = module.lambda_function.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_schedule" {
  count         = var.trigger_lambda_by_schedule == true ? 1 : 0
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda_function.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.lambda_schedule_rule[0].arn
}


# Lambda Trigger Invocation on Cloudwatch Event Rule

resource "aws_cloudwatch_event_rule" "lambda_event_rule" {
  count         = var.trigger_lambda_by_cloudwatch_event_rule == true ? 1 : 0
  name          = "${var.function_name}_event_rule"
  description   = var.lambda_event_pattern_description
  event_pattern = var.event_pattern
}

resource "aws_cloudwatch_event_target" "lambda_event_target" {
  count = var.trigger_lambda_by_cloudwatch_event_rule == true ? 1 : 0
  rule  = aws_cloudwatch_event_rule.lambda_event_rule[0].name
  arn   = module.lambda_function.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_event_rule" {
  count         = var.trigger_lambda_by_cloudwatch_event_rule == true ? 1 : 0
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda_function.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.lambda_event_rule[0].arn
}


# Lambda Trigger Invocation on post to SNS Topic

# Existing SNS Topic
resource "aws_sns_topic_subscription" "lambda_existing_sns_subscription" {
  count     = var.trigger_lambda_by_sns == true && var.sns_existing_topic_name != "" ? 1 : 0
  topic_arn = "arn:aws:sns:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${var.sns_existing_topic_name}"
  protocol  = "lambda"
  endpoint  = module.lambda_function.arn
}

resource "aws_lambda_permission" "allow_existing_sns_invoke" {
  count         = var.trigger_lambda_by_sns == true && var.sns_existing_topic_name != "" ? 1 : 0
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda_function.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = "arn:aws:sns:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:${var.sns_existing_topic_name}"
}

# New SNS Topic specific to this lambda deployment
module "lambda_new_sns_topic" {
  count   = var.trigger_lambda_by_sns == true && var.sns_new_topic_name != "" ? 1 : 0
  source  = "spacelift.hscinternal.com/<org>/sns/aws"
  version = "1.0.0"

  topic_name = var.sns_new_topic_name
}

resource "aws_sns_topic_subscription" "lambda_new_sns_subscription" {
  count      = var.trigger_lambda_by_sns == true && var.sns_new_topic_name != "" ? 1 : 0
  depends_on = [module.lambda_new_sns_topic]
  topic_arn  = module.lambda_new_sns_topic[0].arn
  protocol   = "lambda"
  endpoint   = module.lambda_function.arn
}

resource "aws_lambda_permission" "allow_new_sns_invoke" {
  count         = var.trigger_lambda_by_sns == true && var.sns_new_topic_name != "" ? 1 : 0
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda_function.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = module.lambda_new_sns_topic[0].arn
}
