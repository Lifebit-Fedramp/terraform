variable "acl" {
  description = "The canned ACL to apply."
  type        = string
  default     = null
}

variable "attach_policy" {
  description = "Should an iam policy should be attached to the bucket?"
  type        = bool
  default     = false
}

variable "block_public_acls" {
  description = "Bool to turn public acls on/off."
  type        = bool
  default     = true
}

variable "bucket" {
  description = "Name of the s3 bucket."
  type        = string
  default     = ""
}

variable "policy" {
  description = "JSON policy attached to the bucket"
  type        = string
  default     = ""
}

variable "replication_configuration" {
  description = "Map containing cross-region replication configuration."
  type        = any
  default     = {}
}

variable "server_side_encryption_configuration" {
  description = "Map containing server-side encryption configuration."
  type        = any
  default     = {}
}

variable "tags" {
  description = "Tags for the S3 bucket."
  type        = map(string)
  default     = {}
}

variable "versioning_enabled" {
  description = "Enable or disable versioning."
  type        = bool
  default     = false
}
