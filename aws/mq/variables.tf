variable "name" {}

variable "engine_type" {
  default = "RabbitMQ"
}

variable "engine_version" {
  default = "3.9.16"
}

variable "instance_type" {
  default = "mq.m5.large"
}

# variable "broker_user" {
#   default = "example_user"
# }

variable "subnet_ids" {}

variable "vpc_id" {}

variable "deployment_mode" {
  description = "The deployment mode of the broker. Supported: SINGLE_INSTANCE, ACTIVE_STANDBY_MULTI_AZ and CLUSTER_MULTI_AZ."
  type        = string
  default     = "CLUSTER_MULTI_AZ"
}

#https://github.com/lifebit-ai/lifebit-infrastructure-modules/blob/master/2-supermodules/mq-broker-aws/variables.tf#L152
variable "mq_broker_tags" {
  description = "A mapping of tags to assign to the resources."
  type        = map(string)
  default     = {}
}

variable "mq_broker_apply_immediately" {
  description = "Specifies whether any cluster modifications are applied immediately, or during the next maintenance window."
  type        = bool
  default     = true
}

variable "mq_broker_auto_minor_version_upgrade" {
  description = "Enables automatic upgrades to new minor versions for brokers, as Apache releases the versions."
  type        = bool
  default     = true
}

variable "mq_broker_maintenance_day_of_week" {
  description = "The maintenance day of the week. e.g. MONDAY, TUESDAY, or WEDNESDAY."
  type        = string
  default     = "SUNDAY"
}

variable "mq_broker_maintenance_time_of_day" {
  description = "The maintenance time, in 24-hour format. e.g. 02:00."
  type        = string
  default     = "03:00"
}

variable "mq_broker_maintenance_time_zone" {
  description = "The maintenance time zone, in either the Country/City format, or the UTC offset format. e.g. CET."
  type        = string
  default     = "UTC"
}

variable "mq_broker_logs_general" {
  description = "Enables general logging via CloudWatch"
  type        = bool
  default     = false
}

variable "mq_broker_logs_audit" {
  description = "Enables audit logging. User management action made using JMX or the ActiveMQ Web Console is logged."
  type        = bool
  default     = false
}
