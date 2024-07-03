variable "name" {
  type        = string
  description = "The name of the user to create."
}

variable "rotation_days" {
  type        = number
  description = "The number of days before the iam creds are rotated."
  default     = 30

  validation {
    condition     = var.rotation_days >= 2
    error_message = "rotation_days must be greater than or equal to 2"
  }
}