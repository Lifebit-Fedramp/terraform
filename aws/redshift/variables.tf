variable "subnet_ids" {
  description = "The AWS Subnet IDs for Redshift"
  type        = list(string)
}

variable "vpc_id" {
  description = "The VPC ID for Redshift"
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "key_administrator_arn" {
  description = "The ARN of the KMS key administrator"
  type        = string
}

variable "database_name" {
  description = "The name of the Redshift database"
  default     = "uat"
  type        = string
}

variable "node_type" {
  description = "The node type of the Redshift database"
  default     = "dc2.large"
  type        = string
}

variable "number_of_nodes" {
  description = "The number of nodes for the Redshift database"
  default     = 1
  type        = number
}

variable "cluster_name" {
  description = "The name of the cluster"
  type        = string
}

variable "logging_enabled" {
  description = "Whether or not logging is enabled"
  type        = bool
  default     = true
}

variable "logging_bucket" {
  description = "The bucket to log to when logging is enabled"
  type        = string
}
