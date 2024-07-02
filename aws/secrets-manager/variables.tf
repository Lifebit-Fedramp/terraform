variable "name" {
  description = "Name of the resource"
  type        = string
}

variable "description" {
  description = "Description of the resource"
  type        = string
}

variable "kms_key_id" {
  description = "ID or ARN of KMS Key used to encrypt"
  type        = string
  default     = ""
}

variable "allow_cross_account_access" {
  description = "Boolean for whether to use KMS key encryption"
  type        = bool
  default     = false
}

variable "account_role_arn_list" {
  description = "List of Account ARNs with access to Secret"
  type        = list(string)
  default     = [""] # Defaults to no permissions
}