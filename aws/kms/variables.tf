variable "aliases" {
  description = "A list of aliases to create. Must not be computed values."
  type        = string
  default     = ""
}

variable "cmk_encryption" {
  description = "Encryption to be used, i.e. SYMMETRIC_DEFAULT, RSA_2048, RSA_4096, ECC_NIST_P256, etc."
  type        = string
  default     = "SYMMETRIC_DEFAULT"
}

variable "deletion_window" {
  description = "Amount of time before CMK is deletd in days."
  type        = number
  default     = 30
}

variable "description" {
  description = "Description of the KMS Key."
  type        = string
  default     = ""
}

variable "is_replica" {
  description = "Determines if the key is a replica."
  type        = bool
  default     = false
}

variable "key_enabled" {
  description = "Specifies whether the key is enabled."
  type        = bool
  default     = true
}

variable "key_usage" {
  description = "Specifies the intended use of the key."
  type        = string
  default     = "ENCRYPT_DECRYPT"
}

variable "multi_region" {
  description = "Indicates whether the KMS key is a multi-Region or regional key."
  type        = bool
  default     = false
}

variable "primary_key_arn" {
  description = "The primary key arn of a multi-region replica key."
  type        = string
  default     = null
}

variable "rotation_enabled" {
  description = "Specifies whether key rotation is enabled."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags for the KMS key."
  type        = map(string)
  default     = {}
}

variable "alias" {
  default = "alias/shared-ebs-default"
}

variable "policy" {
  default = null
}
