variable "security_hub_standards" {
  description = "A group of controls that constitute requirements"
  type        = list(string)
  default = [
    "standards/aws-foundational-security-best-practices/v/1.0.0",
    "standards/cis-aws-foundations-benchmark/v/1.4.0"
  ]
}

variable "create_security_hub_resource" {
  description = "Whether or not security hub should be enabled in this region"
  type        = bool
  default     = false
}

variable "is_govcloud" {
  description = "Whether or not this is deployed in GovCloud. This affects the arn of the standards being used."
  type        = bool
  default     = true
}
