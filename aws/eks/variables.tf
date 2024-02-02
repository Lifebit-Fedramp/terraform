variable "instance_type" {
  default     = "t3a.xlarge"
  type        = string
  description = "Instance type to use for the cluster"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID to use for the cluster"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs to use for the cluster"
}

variable "ami_id" {
  type        = string
  description = "override AMI ID to use for the cluster"
  default     = ""
}

variable "cluster_name" {
  type        = string
  description = "Name of the cluster"
}

variable "flux_repo_name" {
  type        = string
  description = "Name of the Flux repo"
  default     = "kubernetes-clusters"
}

variable "account_name" {
  type        = string
  description = "Name of the account this cluster belongs to"
}

variable "enable_external_secrets" {
  type        = bool
  description = "Enable external secrets"
  default     = true
}

variable "enable_spacelift_oidc" {
  type        = bool
  description = "Enable if spacelift is in this cluster"
  default     = false
}

variable "mng_max_size" {
  type        = number
  description = "Maximum number of nodes in the managed node group"
  default     = 3
}

variable "mng_desired_size" {
  type        = number
  description = "Desired number of nodes in the managed node group"
  default     = 3
}

variable "enable_lb_controller_oidc" {
  type        = bool
  description = "Enable if alb ingress controller is in this cluster"
  default     = false
}

variable "enable_cluster_autoscaler_oidc" {
  type        = bool
  description = "Enable if cluster autoscaler is in this cluster"
  default     = true
}

variable "control_plane_allowed_cidrs" {
  type        = list(string)
  description = "List of CIDRs to allow access to the control plane"
  default     = []
}

variable "volume_size" {
  type        = number
  description = "Size of the EBS volume to use for the cluster"
  default     = 20
}

variable "additional_self_managed_node_groups" {
  type        = any
  description = "Additional self managed node groups to create"
  default     = {}
}

variable "dns_name" {
  type        = string
  description = "DNS name to use for the cluster"
}

variable "additional_node_security_group_rules" {
  type        = map(any)
  description = "Additional security group rules to add to the node security group"
  default     = {}
}

variable "cluster_version" {
  type        = string
  description = "Kubernetes version to use for the cluster"
  default     = "1.23"
}

variable "additional_kubectl_access" {
  type = list(object({
    rolearn  = string
    groups   = list(string)
    username = string
  }))
  description = "Additional users to add to the kubectl config"
  default     = []
}

variable "enable_cluster_addons" {
  description = "Boolean for whether to manage eks addons with terraform / EKS"
  type        = bool
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "EKS tags"
  default     = {}
}
