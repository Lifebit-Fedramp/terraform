variable "additional_cidrs" {
  description = "Additional CIDRs with access to cluster"
  type        = list(string)
  default     = []
}

variable "additional_sg_ids" {
  description = "Additional Security Group IDs with access to cluster."
  type        = list(string)
  default     = []
}

variable "allocated_storage" {
  type        = number
  description = "RDS storage"
  default     = 20
}

variable "apply_immediately" {
  type        = bool
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window"
  default     = false
}

variable "backup_retention_period" {
  type        = number
  description = "RDS backup retention period"
  default     = 7
}

variable "backup_window" {
  type        = string
  description = "RDS backup window"
  default     = "03:00-06:00"
}

variable "db_engine" {
  type        = string
  description = "RDS engine"
  default     = "mysql"
}

variable "db_engine_version" {
  type        = string
  description = "RDS Engine Version"
  default     = "8.0.32"
}

variable "db_family" {
  type        = string
  description = "RDS instance family"
  default     = "mysql8.0"
}

variable "db_identifier" {
  type        = string
  description = "The name of the RDS instance."
}

variable "db_master_username" {
  type        = string
  description = "RDS username"
  default     = "root"
}

variable "db_name" {
  type        = string
  description = "The DB name to create.  If omitted, no database is initially created."
}

variable "instance_class" {
  type        = string
  description = "RDS instance class"
  default     = "db.m6g.large"
}

variable "maint_window" {
  type        = string
  description = "RDS maintenance window"
  default     = "Mon:00:00-Mon:03:00"
}

variable "major_engine_version" {
  type        = string
  description = "RDS DB Option Group Engine version"
  default     = "8.0"
}

variable "max_allocated_storage" {
  type        = number
  description = "When configured, the upper limit to which Amazon RDS can automatically scale the storage of the DB instance. Configuring this will automatically ignore differences to allocated_storage. Must be greater than or equal to allocated_storage or 0 to disable Storage Autoscaling."
  default     = 0
}

variable "monitoring_interval" {
  type        = number
  description = "RDS monitoring interval"
  default     = 60
}

variable "multi_az" {
  type        = bool
  description = "Multi-AZ DB clusters aren't available in govcloud"
  default     = false
}

variable "performance_insights_enabled" {
  type        = bool
  description = "Enable RDS Performance Insights."
  default     = false
}

variable "performance_insights_retention_period" {
  type        = number
  description = "RDS performance insights retention period"
  default     = 7
}

variable "port" {
  type        = number
  description = "RDS port"
  default     = 3306
}

variable "publicly_accessible" {
  type        = bool
  description = "Bool to control if instance is publicly accessible"
  default     = false
}

variable "storage_type" {
  type        = string
  description = "Storage type to use on RDS io1/gp2/gp3"
  default     = "gp3"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs"
}

variable "tags" {
  type        = map(string)
  description = "RDS tags"
  default     = {}
}

variable "transit_cidr" {
  description = "CIDR block of Transit CIDR"
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
  default     = ""
}
