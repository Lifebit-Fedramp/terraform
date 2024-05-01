variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "access_sg_ids" {
  description = "Additional Security Group IDs with access to cluster."
  type        = list(string)
  default     = null
}

variable "access_cidrs" {
  description = "Additional CIDRs with access to cluster"
  type        = list(string)
  default     = null
}

variable "db_subnet_ids" {
  description = "VPC Subnet IDs"
  type        = set(string)
}

variable "db_cluster_identifier" {
  description = "DB Cluster Identifier"
  type        = string
}

variable "db_instance_count" {
  description = "DB Instance Count"
  type        = number
  default     = 2
}

variable "db_name" {
  description = "DB Name"
  type        = string
}

variable "db_engine" {
  description = "DB Engine"
  type        = string
}

variable "db_engine_version" {
  description = "DB Engine Version"
  type        = string
}

variable "db_instance_class" {
  description = "DB Instance Class"
  type        = string
  default     = "db.t3.medium"
}

variable "db_storage_encrypted" {
  description = "DB Storage Encrypted"
  type        = bool
  default     = true
}

variable "db_master_username" {
  description = "DB Master Username"
  default     = "admin"
  type        = string
}

variable "db_family" {
  description = "Database Family"
  type        = string
}

variable "mysql_log_types" {
  description = "Types of mysql RDS logging for cloudwatch log groups"
  type        = list(string)
  default     = ["general", "audit", "slowquery", "error"]
}

variable "psql_log_types" {
  description = "Types of postgresql RDS logging for cloudwatch log groups"
  type        = list(string)
  default     = ["postgresql"]
}

variable "log_prefix" {
  description = "RDS cloudwatch log prefix"
  type        = string
  default     = "/aws/rds/cluster"
}

variable "backup_retention_period" {
  description = "Backup retention period in days"
  type        = number
  default     = 30
}

variable "tags" {
  type        = map(string)
  description = "RDS tags"
  default     = {}
}

variable "serverlessv2_max_capacity" {
  type        = number
  description = "max capacity for serverlessv2"
  default     = 1.0
}

variable "serverlessv2_min_capacity" {
  type        = number
  description = "min capacity for serverlessv2"
  default     = 0.5
}
