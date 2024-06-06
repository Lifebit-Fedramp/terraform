variable "ssm_parameters" {
  description = "Map of SSM Parameters to create"
  type        = any
  default     = []
}

variable "path_prefix" {
  description = "Path prefix to use for SSM Parameters"
  type        = string
  default     = ""
}

variable "key_id" {
  description = "ID of KMS key to encrypt SecureStrings with"
  type        = string
  default     = ""
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "identifier" {
  description = "Identifier for the group of SSM Parameters"
  type        = string
  default     = ""
}
