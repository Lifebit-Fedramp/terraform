variable "name" {
  type = string
}

variable "description" {
  type = string
}

variable "allowed_ips" {
  type        = list(string)
  default     = []
  description = "List of IP addresses allowed to connect to the loadbalancer, if none then all can connect."
}
