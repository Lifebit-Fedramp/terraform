variable "environment_name" {
  type        = string
  description = "Name of the Environment in K8s"
}

variable "queue_name" {
  type        = string
  description = "Name of SQS queue"
}

variable "dl_queue_name" {
  type        = string
  description = "Name of dead letter SQS queue used for messages that fail to be received"
}

variable "kms_key_id" {
  type        = string
  description = "ID of kms key used to encrypt and decrypt messages"
}

variable "publisher_service_url" {
  type        = string
  description = "URL of AWS service publishing to queue (e.g. sns.amazonaws.com)"
}

variable "publisher_arn" {
  type        = string
  description = "ARN of AWS service publishing to queue (e.g. SNS topic or other)"
}
