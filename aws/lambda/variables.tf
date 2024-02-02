variable "function_name" {
  type        = string
  description = "Name of the lambda function. This should match the file name of the main lambda file without the file extensions. E.G. if the lambda name is MyLambda, the main lambda file to invoke inside the deployment package should be MyLambda.py"
}

variable "handler_file" {
  type        = string
  default     = "lambda_function"
  description = "Name of the lambda handler file."
}

variable "handler_function" {
  type        = string
  default     = "lambda_handler"
  description = "Name of the lambda handler function excluding the filename. If your lambda function is named lambda_function and invocation should call lambda_handler(), this value would be lambda_handler"
}

variable "description" {
  type        = string
  default     = ""
  description = "Description of the lambda function."
}

variable "runtime" {
  type        = string
  default     = "python3.9"
  description = "Lambda function runtime from list defined at https://docs.aws.amazon.com/lambda/latest/dg/lambda-runtimes.html"
}

variable "memory_size" {
  type        = number
  default     = "128"
  description = "Memory allocated to Lambda invocations."
}

variable "timeout" {
  type        = number
  default     = "900"
  description = "Maximum runtime per invocation. Maximum value allowed is 900 (15 minutes)."
}

variable "s3_bucket" {
  type        = string
  default     = "lambda-deployment-pkgs"
  description = "Lambda function runtime from list defined at https://docs.aws.amazon.com/lambda/latest/dg/lambda-runtimes.html"
}

variable "environment_variables" {
  type        = map(string)
  default     = {}
  description = "Environmental variables for lambda use."
}

variable "vpc_subnet_ids" {
  type        = list(string)
  default     = []
  description = "If Lambda requires VPC access, list of subnet IDs."
}

variable "vpc_security_group_ids" {
  type        = list(string)
  default     = []
  description = "If Lambda requires VPC access, list of security group IDs."
}

variable "health_monitor_sns_topic" {
  type        = string
  description = "SNS Topic to send handled/unhandled exception messages to. Handled exception default is alarm on ERROR log levels."
}

variable "health_monitor_log_level" {
  type        = string
  default     = "ERROR"
  description = "Handled exceptions log level to alarm on."
}

# IAM policy attachments. Make sure policies exist before referencing.
variable "policies" {
  type        = list(string)
  description = "list of IAM policy ARNs to attach to lambda role. Only attaches to role when length > 0"
  default     = ["arn:aws-us-gov:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"]
}

variable "policy_jsons" {
  type        = list(string)
  description = "List of additional policy documents as JSON to attach to Lambda Function role"
  default     = []
}

# Lambda Function Triggers - Stands up infrastructure to invoke Lambda by desired method

# Trigger on Schedule
# https://docs.aws.amazon.com/lambda/latest/dg/services-cloudwatchevents-expressions.html

variable "trigger_lambda_by_schedule" {
  type    = bool
  default = false
}

variable "lambda_schedule_description" {
  type    = string
  default = "Schedule for Lambda Function."
}

variable "schedule_expression" {
  type        = string
  description = "The job frequency, using schedule expressions (link in comments above)"
  default     = "rate(1 day)"
}

# Trigger on event patterns
# https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/CloudWatchEventsandEventPatterns.html

variable "trigger_lambda_by_cloudwatch_event_rule" {
  type    = bool
  default = false
}

variable "lambda_event_pattern_description" {
  type    = string
  default = "Schedule for Lambda Function."
}

variable "event_pattern" {
  type        = string
  description = "The job frequency, using event patterns (link above)"
  default     = ""
  # example, must be all double quotes and escaped inside of json
  # "{\"source\": [\"aws.ec2\"],\"detail-type\": [\"EC2 Instance State-change Notification\"],\"detail\": {\"state\": [\"running\"]}}"
}

# Trigger on SNS Topic Post

variable "trigger_lambda_by_sns" {
  type    = bool
  default = false
}

variable "sns_new_topic_name" {
  type        = string
  description = "Name to give new SNS topic and subscribe lambda function to it"
  default     = ""
}

variable "sns_existing_topic_name" {
  type        = string
  description = "name of existing SNS topic to subscribe lambda to"
  default     = ""
}
