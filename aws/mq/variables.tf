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

variable "broker_user" {
  default = "example_user"
}

variable "subnet_ids" {}

variable "vpc_id" {}
