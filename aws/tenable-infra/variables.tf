variable "key_name" {
  description = "KMS key pair name"
  type        = string
}

variable "create_key_pair" {
  description = "Boolean to create a KMS key"
  type        = bool
  default     = false
}

variable "ec2_instance_name" {
  description = "Name of the EC2 Instance"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the EC2 Instance"
  type        = string
}

variable "ignore_ami_changes" {
  description = "ignore ami changes"
  type        = bool
}

variable "ec2_instance_type" {
  description = "EC2 Instance type"
  type        = string
  default     = "t2.micro"
}

variable "subnet_id" {
  description = "The VPC Subnet ID to launch in"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with"
  type        = list(string)
}

variable "tenable_key_param_store" {
  description  = "arn for paramstore where tenable key can be retrieved"
  type         = string
}

variable "tenable_was_ecr_repo" {
  description = "tenable was ecr repo arn"
  type        = string
}

variable "tenable_was_name_parm_store" {
  description = "tenable was name param store"
  type        = string
}
