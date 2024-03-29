variable "cidr_range" {}
variable "firewall_subnets" {
  default = []
}
variable "public_subnets" {}
variable "public_dmz_subnets" {
  default = []
}
variable "private_subnets" {}
variable "private_ec2_subnets" {
  default = []
}
variable "transit_gateway_subnets" {
  default = []
}

variable "name" {
  description = "Name for this VPC and subsequent resources"
  type        = string
  validation {
    condition = (
      can(regex("^[a-zA-Z0-9]([a-zA-Z0-9]*-[a-zA-Z0-9])*[a-zA-Z0-9]+$", var.name)) &&
      length(var.name) <= 128
    )
    error_message = "Invalid name. The name must have 1-128 characters. Valid characters: a-z, A-Z, 0-9 and -(hyphen). The name can’t start or end with a hyphen, and it can’t contain two consecutive hyphens."
  }
}

variable "create_vpn" {
  description = "Turns VPC creatin on and off for accounts"
  type        = bool
  default     = true
}

variable "vpn_cidr" {
  default = "10.0.0.0/16"
}

variable "tgw_cidr" {
  default = ""
}

variable "tgw_id" {
  default = ""
}

variable "attach_tgw_to_vpc" {
  default     = false
  description = "Attach the transit gateway to the VPC"
  type        = bool
}

variable "flow_logs_bucket" {
  description = "Bucket arn for flow logs"
  type        = string
}

variable "fips_enabled" {
  default     = true
  description = "Whether or not fips endpoints are enabled"
  type        = bool
}

variable "use_default_nacl_copy" {
  default     = true
  description = "Turns off custom NACLs for testing"
  type        = bool
}

variable "eks_node_groups_sg_id" {
  default     = ""
  description = "Security group id of the eks node group."
  type        = string
}

variable "endpoint_private_dns_endpoints_enabled" {
  default     = true
  description = "Toggles private dns endpoints for VPC endpoints"
  type        = bool
}

variable "nacl_egress_rules" {
  default     = []
  description = "Additional NACL egress rules for all subnets. Prepended to more specific rules."
  type = list(object({
    protocol   = string
    action     = string
    cidr_block = string
    from_port  = number
    to_port    = number
  }))
}

variable "nacl_fw_egress_rules" {
  default     = []
  description = "Additional NACL egress rules for FW subnets"
  type = list(object({
    protocol   = string
    action     = string
    cidr_block = string
    from_port  = number
    to_port    = number
  }))
}

variable "nacl_private_egress_rules" {
  default     = []
  description = "Additional NACL egress rules for PRV subnets"
  type = list(object({
    protocol   = string
    action     = string
    cidr_block = string
    from_port  = number
    to_port    = number
  }))
}

variable "nacl_public_egress_rules" {
  default     = []
  description = "Additional NACL egress rules for PUB subnets"
  type = list(object({
    protocol   = string
    action     = string
    cidr_block = string
    from_port  = number
    to_port    = number
  }))
}


variable "nacl_tgw_egress_rules" {
  default     = []
  description = "Additional NACL egress rules for TGW subnets"
  type = list(object({
    protocol   = string
    action     = string
    cidr_block = string
    from_port  = number
    to_port    = number
  }))
}

variable "nacl_ingress_rules" {
  default     = []
  description = "Additional NACL ingress rules for all subnets. Prepended to more specific rules."
  type = list(object({
    protocol   = string
    action     = string
    cidr_block = string
    from_port  = number
    to_port    = number
  }))
}

variable "nacl_fw_ingress_rules" {
  default     = []
  description = "Additional NACL ingress rules for FW subnets"
  type = list(object({
    protocol   = string
    action     = string
    cidr_block = string
    from_port  = number
    to_port    = number
  }))
}

variable "nacl_private_ingress_rules" {
  default     = []
  description = "Additional NACL ingress rules for PRV subnets"
  type = list(object({
    protocol   = string
    action     = string
    cidr_block = string
    from_port  = number
    to_port    = number
  }))
}

variable "nacl_public_ingress_rules" {
  default     = []
  description = "Additional NACL ingress rules for PUB subnets"
  type = list(object({
    protocol   = string
    action     = string
    cidr_block = string
    from_port  = number
    to_port    = number
  }))
}

variable "nacl_tgw_ingress_rules" {
  default     = []
  description = "Additional NACL ingress rules for TGW subnets"
  type = list(object({
    protocol   = string
    action     = string
    cidr_block = string
    from_port  = number
    to_port    = number
  }))
}

variable "tls_firewall_egress_allowlist" {
  default     = {}
  description = "domains allowed to egress out of the vpc"
  type = map(list(object({
    # Majority of the items in this object are unused by terraform, but are required for auditing.
    destination   = string
    owned_by      = string
    approved_by   = string
    approved_date = string
    description   = string
  })))
}

variable "rules_source_list" {
  default     = []
  description = "domains allowed to egress out of the vpc"
  type = list(object({
    # Majority of the items in this object are unused by terraform
    # but we need them for auditing purposes. Please dont remove without approval.
    destination   = string
    owned_by      = string
    approved_by   = string
    approved_date = string
    description   = string
  }))
}

variable "http_firewall_egress_allowlist" {
  default = ["google.com"]
  description = "domains allowed to egress out of the vpc"
}

variable "enable_firewall" {
  default = false
}

variable "enable_s3_endpoint" {
  default = false
}

variable "enable_ecr_endpoints" {
  default = false
}