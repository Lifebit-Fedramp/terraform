variable "use_default_key" {
  description = "Uses default key for default ebs encryption across account."
  type        = bool
  default     = true
}

variable "kms_key_arn" {
  description = "KMS key resource ARN."
  type        = string
  default     = null
}
