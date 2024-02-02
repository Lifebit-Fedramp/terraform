variable "enable_analyzer" {
  description = "Variable used to enable/disable access analyzer in an account"
  type        = bool
  default     = false
}

variable "password_policy" {
  description = "Variable used to enable/disable password policies in an account"
  type        = bool
  default     = true
}