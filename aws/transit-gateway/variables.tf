variable "accounts_to_share" {
  description = "aws account ids to share the tgw with"
  type        = list(string)
  default     = []
}

variable "name" {
  description = "name of the tgw"
  type        = string
}

variable "create_tgw_rt" {
  description = "Turns off creation of route table for transit gateways."
  type        = bool
  default     = false
}

variable "flow_logs_bucket" {
  description = "Bucket arn for flow logs"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "aws_orgs_arn" {
  description = "The AWS Orgs ARN principal to associate with the resource share."
  type        = string
}

variable "accept_tgw_attachment" {
  description = "True false value to accept transit gateway attachments"
  type        = bool
  default     = false  
}

variable "vpc_attachment_id_map" {
  description = "List of VPC attachment IDs"
  type        = map(any)
  default     = {}
}
