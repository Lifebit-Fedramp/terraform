terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.20.0"
    }
  }
}


resource "aws_config_config_rule" "access-keys-rotated" {
  name             = "access-keys-rotated"
  description      = "Checks if the active access keys are rotated within 90 days."
  input_parameters = jsonencode({ maxAccessKeyAge = "90" })

  source {
    owner             = "AWS"
    source_identifier = "ACCESS_KEYS_ROTATED"
  }
}

resource "aws_config_config_rule" "account-part-of-organizations" {
  name        = "account-part-of-organizations"
  description = "Checks whether AWS account is part of AWS Organizations."

  source {
    owner             = "AWS"
    source_identifier = "ACCOUNT_PART_OF_ORGANIZATIONS"
  }
}

resource "aws_config_config_rule" "acm-cert-expiration" {
  name        = "acm-cert-expiration"
  description = "Checks ACM cert for expiration date within 14 days."

  source {
    owner             = "AWS"
    source_identifier = "ACM_CERTIFICATE_EXPIRATION_CHECK"
  }
}

resource "aws_config_config_rule" "alb-http-drop-invalid-header-enabled" {
  name        = "alb-http-drop-invalid-header-enabled"
  description = "Checks if rule evaluates AWS Application Load Balancers (ALB) to ensure they are configured to drop http headers"

  source {
    owner             = "AWS"
    source_identifier = "ALB_HTTP_DROP_INVALID_HEADER_ENABLED"
  }
}

resource "aws_config_config_rule" "alb-http-to-https-redirection-check" {
  name        = "alb-http-to-https-redirection-check"
  description = "Checks if HTTP to HTTPS redirection is configured on all HTTP listeners of Application Load Balancers."

  source {
    owner             = "AWS"
    source_identifier = "ALB_HTTP_TO_HTTPS_REDIRECTION_CHECK"
  }
}

resource "aws_config_config_rule" "api-gw-cache-enabled-and-encrypted" {
  name        = "api-gw-cache-enabled-and-encrypted"
  description = "Checks that all methods in Amazon API Gateway stages have cache enabled and cache encrypted."

  source {
    owner             = "AWS"
    source_identifier = "API_GW_CACHE_ENABLED_AND_ENCRYPTED"
  }
}

resource "aws_config_config_rule" "api-gw-execution-logging-enabled" {
  name        = "api-gw-execution-logging-enabled"
  description = "Checks that all methods in Amazon API Gateway stage has logging enabled."

  source {
    owner             = "AWS"
    source_identifier = "API_GW_EXECUTION_LOGGING_ENABLED"
  }
}

resource "aws_config_config_rule" "autoscaling-group-elb-healthcheck-required" {
  name        = "autoscaling-group-elb-healthcheck-required"
  description = "Checks if your Auto Scaling groups that are associated with a Classic Load Balancer are using Elastic Load Balancing health checks."

  source {
    owner             = "AWS"
    source_identifier = "AUTOSCALING_GROUP_ELB_HEALTHCHECK_REQUIRED"
  }
}

resource "aws_config_config_rule" "cloudtrail-s3-dataevents-enabled" {
  name        = "cloudtrail-s3-dataevents-enabled"
  description = "Checks whether at least one AWS CloudTrail trail is logging Amazon S3 data events for all S3 buckets."

  source {
    owner             = "AWS"
    source_identifier = "CLOUDTRAIL_S3_DATAEVENTS_ENABLED"
  }
}

resource "aws_config_config_rule" "cloud-trail-cloud-watch-logs-enabled" {
  name        = "cloud-trail-cloud-watch-logs-enabled"
  description = "Checks whether AWS CloudTrail trails are configured to send logs to Amazon CloudWatch logs."

  source {
    owner             = "AWS"
    source_identifier = "CLOUD_TRAIL_CLOUD_WATCH_LOGS_ENABLED"
  }
}

resource "aws_config_config_rule" "cloudtrail-enabled" {
  name        = "cloudtrail-enabled"
  description = "Checks if an AWS CloudTrail trail is enabled in your AWS account."

  source {
    owner             = "AWS"
    source_identifier = "CLOUD_TRAIL_ENABLED"
  }
}

resource "aws_config_config_rule" "cloud-trail-encryption-enabled" {
  name        = "cloud-trail-encryption-enabled"
  description = "Checks if AWS CloudTrail is configured to use the server side encryption (SSE) AWS Key Management Service (AWS KMS) encryption."

  source {
    owner             = "AWS"
    source_identifier = "CLOUD_TRAIL_ENCRYPTION_ENABLED"
  }
}

resource "aws_config_config_rule" "cloud-trail-log-file-validation-enabled" {
  name        = "cloud-trail-log-file-validation-enabled"
  description = "Checks whether AWS CloudTrail creates a signed digest file with logs. AWS recommends that the file validation must be enabled on all trails."

  source {
    owner             = "AWS"
    source_identifier = "CLOUD_TRAIL_LOG_FILE_VALIDATION_ENABLED"
  }
}

resource "aws_config_config_rule" "cloudtrail-security-trail-enabled" {
  name        = "cloudtrail-security-trail-enabled"
  description = "Checks that there is at least one AWS CloudTrail trail defined with security best practices."

  source {
    owner             = "AWS"
    source_identifier = "CLOUDTRAIL_SECURITY_TRAIL_ENABLED"
  }
}

resource "aws_config_config_rule" "cloudwatch-alarm-action-check" {
  name        = "cloudwatch-alarm-action-check"
  description = "Checks whether CloudWatch alarms have at least one alarm action, one INSUFFICIENT_DATA action, or one OK action enabled."
  input_parameters = jsonencode({
    "alarmActionRequired" : "true",
    "insufficientDataActionRequired" : "false",
    "okActionRequired" : "false"
  })

  source {
    owner             = "AWS"
    source_identifier = "CLOUDWATCH_ALARM_ACTION_CHECK"
  }
}

resource "aws_config_config_rule" "cloudwatch-log-group-encrypted" {
  name        = "cloudwatch-log-group-encrypted"
  description = "Checks if a log group in Amazon CloudWatch Logs is encrypted with a AWS Key Management Service (KMS) managed Customer Master Keys (CMK)."

  source {
    owner             = "AWS"
    source_identifier = "CLOUDWATCH_LOG_GROUP_ENCRYPTED"
  }
}

resource "aws_config_config_rule" "cmk-backing-key-rotation-enabled" {
  name        = "cmk-backing-key-rotation-enabled"
  description = "Checks if automatic key rotation is enabled for every AWS Key Management Service (AWS KMS) customer managed symmetric encryption key."

  source {
    owner             = "AWS"
    source_identifier = "CMK_BACKING_KEY_ROTATION_ENABLED"
  }
}

resource "aws_config_config_rule" "cw-loggroup-retention-period-check" {
  name        = "cw-loggroup-retention-period-check"
  description = "Checks if Amazon CloudWatch LogGroup retention period is set to specific number of days."

  source {
    owner             = "AWS"
    source_identifier = "CW_LOGGROUP_RETENTION_PERIOD_CHECK"
  }
}

resource "aws_config_config_rule" "db-instance-backup-enabled" {
  name        = "db-instance-backup-enabled"
  description = "Checks if RDS DB instances have backups enabled. Optionally, the rule checks the backup retention period and the backup window."

  source {
    owner             = "AWS"
    source_identifier = "DB_INSTANCE_BACKUP_ENABLED"
  }
}

resource "aws_config_config_rule" "dynamodb-pitr-enabled" {
  name        = "dynamo-pitr-enabled"
  description = "Checks that point in time recovery (PITR) is enabled for Amazon DynamoDB tables."

  source {
    owner             = "AWS"
    source_identifier = "DYNAMODB_PITR_ENABLED"
  }
}

resource "aws_config_config_rule" "dynamodb-table-encrypted-kms" {
  name        = "dynamodb-table-encrypted-kms"
  description = "Checks if Amazon DynamoDB table is encrypted with AWS Key Management Service (KMS)."

  source {
    owner             = "AWS"
    source_identifier = "DYNAMODB_TABLE_ENCRYPTED_KMS"
  }
}

resource "aws_config_config_rule" "ebs-optimized-instance" {
  name        = "ebs-optimized-instance"
  description = "Checks if EBS optimization is enabled for your EC2 instances that can be EBS-optimized."

  source {
    owner             = "AWS"
    source_identifier = "EBS_OPTIMIZED_INSTANCE"
  }
}

resource "aws_config_config_rule" "ebs-snapshot-public-restorable-check" {
  name        = "ebs-snapshot-public-restorable-check"
  description = "Checks whether Amazon Elastic Block Store (Amazon EBS) snapshots are not publicly restorable."

  source {
    owner             = "AWS"
    source_identifier = "EBS_SNAPSHOT_PUBLIC_RESTORABLE_CHECK"
  }
}

resource "aws_config_config_rule" "ec2-ebs-encryption-by-default" {
  name        = "ec2-ebs-encryption-by-default"
  description = "Check that Amazon Elastic Block Store (EBS) encryption is enabled by default."

  source {
    owner             = "AWS"
    source_identifier = "EC2_EBS_ENCRYPTION_BY_DEFAULT"
  }
}

resource "aws_config_config_rule" "ec2-imdsv2-check" {
  name        = "ec2-imdsv2-check"
  description = "Checks whether your Amazon Elastic Compute Cloud (Amazon EC2) instance metadata version is configured with Instance Metadata Service Version 2 (IMDSv2)."

  source {
    owner             = "AWS"
    source_identifier = "EC2_IMDSV2_CHECK"
  }
}

resource "aws_config_config_rule" "ec2-instance-managed-by-systems-manager" {
  name        = "ec2-instance-managed-by-systems-manager"
  description = "Checks whether the Amazon EC2 instances in your account are managed by AWS Systems Manager."

  source {
    owner             = "AWS"
    source_identifier = "EC2_INSTANCE_MANAGED_BY_SSM"
  }
}

resource "aws_config_config_rule" "ec2-instance-no-public-ip" {
  name        = "ec2-instance-no-public-ip"
  description = "Checks whether Amazon Elastic Compute Cloud (Amazon EC2) instances have a public IP association."

  source {
    owner             = "AWS"
    source_identifier = "EC2_INSTANCE_NO_PUBLIC_IP"
  }
}

resource "aws_config_config_rule" "ec2-instances-in-vpc" {
  name        = "ec2-instances-in-vpc"
  description = "Checks if your EC2 instances belong to a virtual private cloud (VPC). Optionally, you can specify the VPC ID to associate with your instances."

  source {
    owner             = "AWS"
    source_identifier = "INSTANCES_IN_VPC"
  }
}

resource "aws_config_config_rule" "ec2-managedinstance-association-compliance-status-check" {
  name        = "ec2-managedinstance-association-compliance-status-check"
  description = "Checks if the status of the AWS Systems Manager association compliance is COMPLIANT or NON_COMPLIANT after the association execution on the instance."

  source {
    owner             = "AWS"
    source_identifier = "EC2_MANAGEDINSTANCE_ASSOCIATION_COMPLIANCE_STATUS_CHECK"
  }
}

resource "aws_config_config_rule" "ec2-managedinstance-patch-compliance-status-check" {
  name        = "ec2-managedinstance-patch-compliance-status-check"
  description = "Checks whether the compliance status of the AWS Systems Manager patch compliance is COMPLIANT or NON_COMPLIANT after the patch installation on the instance."

  source {
    owner             = "AWS"
    source_identifier = "EC2_MANAGEDINSTANCE_PATCH_COMPLIANCE_STATUS_CHECK"
  }
}

resource "aws_config_config_rule" "ec2-security-group-attached-to-eni" {
  name        = "ec2-security-group-attached-to-eni"
  description = "Checks if non-default security groups are attached to Elastic network interfaces (ENIs)."

  source {
    owner             = "AWS"
    source_identifier = "EC2_SECURITY_GROUP_ATTACHED_TO_ENI"
  }
}

resource "aws_config_config_rule" "ec2-stopped-instance" {
  name        = "ec2-stopped-instance"
  description = "Checks if there are instances stopped for more than the allowed number of days."

  source {
    owner             = "AWS"
    source_identifier = "EC2_STOPPED_INSTANCE"
  }
}

resource "aws_config_config_rule" "ec2-volume-inuse-check" {
  name        = "ec2-volume-inuse-check"
  description = "Checks if EBS volumes are attached to EC2 instances. Optionally checks if EBS volumes are marked for deletion when an instance is terminated."

  source {
    owner             = "AWS"
    source_identifier = "EC2_VOLUME_INUSE_CHECK"
  }
}

resource "aws_config_config_rule" "efs-encrypted-check" {
  name        = "efs-encrypted-check"
  description = "Checks if Amazon Elastic File System (Amazon EFS) is configured to encrypt the file data using AWS Key Management Service (AWS KMS)."

  source {
    owner             = "AWS"
    source_identifier = "EFS_ENCRYPTED_CHECK"
  }
}

resource "aws_config_config_rule" "eip-attached" {
  name        = "eip-attached"
  description = "Checks if all Elastic IP addresses that are allocated to an AWS account are attached to EC2 instances or in-use elastic network interfaces (ENIs)."

  source {
    owner             = "AWS"
    source_identifier = "EIP_ATTACHED"
  }
}

resource "aws_config_config_rule" "eks-secrets-encrypted" {
  name        = "eks-secrets-encrypted"
  description = "Checks if Amazon Elastic Kubernetes Service clusters are configured to have Kubernetes secrets encrypted using AWS Key Management Service (KMS) keys."

  source {
    owner             = "AWS"
    source_identifier = "EKS_SECRETS_ENCRYPTED"
  }
}

resource "aws_config_config_rule" "elasticache-redis-cluster-automatic-backup-check" {
  name        = "elasticache-redis-cluster-automatic-backup-check"
  description = "Check if the Amazon ElastiCache Redis clusters have automatic backup turned on."

  source {
    owner             = "AWS"
    source_identifier = "ELASTICACHE_REDIS_CLUSTER_AUTOMATIC_BACKUP_CHECK"
  }
}

resource "aws_config_config_rule" "elasticsearch-encrypted-at-rest" {
  name        = "elasticsearch-encrypted-at-rest"
  description = "Checks if Elasticsearch domains have encryption at rest configuration enabled."

  source {
    owner             = "AWS"
    source_identifier = "ELASTICSEARCH_ENCRYPTED_AT_REST"
  }
}

resource "aws_config_config_rule" "elasticsearch-in-vpc-only" {
  name        = "elasticsearch-in-vpc-only"
  description = "Checks if Elasticsearch domains are in Amazon Virtual Private Cloud (Amazon VPC)."

  source {
    owner             = "AWS"
    source_identifier = "ELASTICSEARCH_IN_VPC_ONLY"
  }
}

resource "aws_config_config_rule" "elasticsearch-node-to-node-encryption-check" {
  name        = "elasticsearch-node-to-node-encryption-check"
  description = "Check if Elasticsearch nodes are encrypted end to end."

  source {
    owner             = "AWS"
    source_identifier = "ELASTICSEARCH_NODE_TO_NODE_ENCRYPTION_CHECK"
  }
}

resource "aws_config_config_rule" "elb-cross-zone-load-balancing-enabled" {
  name        = "elb-cross-zone-load-balancing-enabled"
  description = "Checks if cross-zone load balancing is enabled for the Classic Load Balancers (CLBs)."

  source {
    owner             = "AWS"
    source_identifier = "ELB_CROSS_ZONE_LOAD_BALANCING_ENABLED"
  }
}

resource "aws_config_config_rule" "elb-deletion-protection-enabled" {
  name        = "elb-deletion-protection-enabled"
  description = "Checks whether an Elastic Load Balancer has deletion protection enabled."

  source {
    owner             = "AWS"
    source_identifier = "ELB_DELETION_PROTECTION_ENABLED"
  }
}

resource "aws_config_config_rule" "elb-logging-enabled" {
  name        = "elb-logging-enabled"
  description = "Checks if the Application Load Balancer and the Classic Load Balancer have logging enabled."

  source {
    owner             = "AWS"
    source_identifier = "ELB_LOGGING_ENABLED"
  }
}

resource "aws_config_config_rule" "elb-tls-https-listeners-only" {
  name        = "elb-tls-https-listeners-only"
  description = "Checks if your Classic Load Balancer is configured with SSL or HTTPS listeners."

  source {
    owner             = "AWS"
    source_identifier = "ELB_TLS_HTTPS_LISTENERS_ONLY"
  }
}

resource "aws_config_config_rule" "emr-kerberos-enabled" {
  name        = "emr-kerberos-enabled"
  description = "Checks if Amazon EMR clusters have Kerberos enabled."

  source {
    owner             = "AWS"
    source_identifier = "EMR_KERBEROS_ENABLED"
  }
}

resource "aws_config_config_rule" "emr-master-no-public-ip" {
  name        = "emr-master-no-public-ip"
  description = "Checks if Amazon Elastic MapReduce (EMR) clusters' master nodes have public IPs."

  source {
    owner             = "AWS"
    source_identifier = "EMR_MASTER_NO_PUBLIC_IP"
  }
}

resource "aws_config_config_rule" "encrypted-volumes" {
  name        = "encrypted-volumes"
  description = "Checks if the EBS volumes that are in an attached state are encrypted."

  source {
    owner             = "AWS"
    source_identifier = "ENCRYPTED_VOLUMES"
  }
}

resource "aws_config_config_rule" "iam-group-has-users-check" {
  name        = "iam-group-has-users-check"
  description = "Checks whether IAM groups have at least one IAM user."

  source {
    owner             = "AWS"
    source_identifier = "IAM_GROUP_HAS_USERS_CHECK"
  }
}

resource "aws_config_config_rule" "iam-no-inline-policy-check" {
  name        = "iam-no-inline-policy-check"
  description = "Checks that inline policy feature is not in use."

  source {
    owner             = "AWS"
    source_identifier = "IAM_NO_INLINE_POLICY_CHECK"
  }
}

resource "aws_config_config_rule" "iam-password-policy" {
  name        = "iam-password-policy"
  description = "Checks if the account password policy for IAM users meets the specified requirements indicated in the parameters."

  source {
    owner             = "AWS"
    source_identifier = "IAM_PASSWORD_POLICY"
  }
}

resource "aws_config_config_rule" "iam-policy-no-statements-with-admin-access" {
  name        = "iam-policy-no-statements-with-admin-access"
  description = "Checks if AWS Identity and Access Management (IAM) policies that you create have Allow statements that grant permissions to all actions on all resources."

  source {
    owner             = "AWS"
    source_identifier = "IAM_POLICY_NO_STATEMENTS_WITH_ADMIN_ACCESS"
  }
}

resource "aws_config_config_rule" "iam-root-access-key-check" {
  name        = "iam-root-access-key-check"
  description = "Checks if the root user access key is available."

  source {
    owner             = "AWS"
    source_identifier = "IAM_ROOT_ACCESS_KEY_CHECK"
  }
}

resource "aws_config_config_rule" "iam-user-group-membership-check" {
  name        = "iam-user-group-membership-check"
  description = "Checks whether IAM users are members of at least one IAM group."

  source {
    owner             = "AWS"
    source_identifier = "IAM_USER_GROUP_MEMBERSHIP_CHECK"
  }
}

resource "aws_config_config_rule" "iam-user-mfa-enabled" {
  name        = "iam-user-mfa-enabled"
  description = "Checks whether the AWS Identity and Access Management users have multi-factor authentication (MFA) enabled."

  source {
    owner             = "AWS"
    source_identifier = "IAM_USER_MFA_ENABLED"
  }
}

resource "aws_config_config_rule" "iam-user-no-policies-check" {
  name        = "iam-user-no-policies-check"
  description = "Checks that none of your IAM users have policies attached. IAM users must inherit permissions from IAM groups or roles."

  source {
    owner             = "AWS"
    source_identifier = "IAM_USER_NO_POLICIES_CHECK"
  }
}

resource "aws_config_config_rule" "iam-user-unused-credentials-check" {
  name             = "iam-user-unused-credentials-check"
  description      = "A config rule that checks whether your AWS Identity and Access Management (IAM) users have passwords or active access keys that have not been used within the specified number of days you provided."
  input_parameters = "{\"maxCredentialUsageAge\":\"90\"}"

  source {
    owner             = "AWS"
    source_identifier = "IAM_USER_UNUSED_CREDENTIALS_CHECK"
  }
}

resource "aws_config_config_rule" "internet-gateway-authorized-vpc-only" {
  name        = "internet-gateway-authorized-vpc-only"
  description = "Checks that Internet gateways (IGWs) are only attached to an authorized Amazon Virtual Private Cloud (VPCs)."

  source {
    owner             = "AWS"
    source_identifier = "INTERNET_GATEWAY_AUTHORIZED_VPC_ONLY"
  }
}

resource "aws_config_config_rule" "kms-cmk-not-scheduled-for-deletion" {
  name        = "kms-cmk-not-scheduled-for-deletion"
  description = "Checks if AWS KMS keys are not scheduled for deletion in AWS Key Management Service (AWS KMS)."

  source {
    owner             = "AWS"
    source_identifier = "KMS_CMK_NOT_SCHEDULED_FOR_DELETION"
  }
}

resource "aws_config_config_rule" "lambda-function-public-access-prohibited" {
  name        = "lambda-function-public-access-prohibited"
  description = "Checks if the AWS Lambda function policy attached to the Lambda resource prohibits public access."

  source {
    owner             = "AWS"
    source_identifier = "LAMBDA_FUNCTION_PUBLIC_ACCESS_PROHIBITED"
  }
}

resource "aws_config_config_rule" "lambda-inside-vpc" {
  name        = "lambda-inside-vpc"
  description = "Checks whether an AWS Lambda function is allowed access to an Amazon Virtual Private Cloud."

  source {
    owner             = "AWS"
    source_identifier = "LAMBDA_INSIDE_VPC"
  }
}

resource "aws_config_config_rule" "mfa-enabled-for-iam-console-access" {
  name        = "mfa-enabled-for-iam-console-access"
  description = "Checks whether AWS Multi-Factor Authentication (MFA) is enabled for all AWS Identity and Access Management (IAM) users that use a console password."

  source {
    owner             = "AWS"
    source_identifier = "MFA_ENABLED_FOR_IAM_CONSOLE_ACCESS"
  }
}

resource "aws_config_config_rule" "multi-region-cloudtrail-enabled" {
  name        = "multi-region-cloudtrail-enabled"
  description = "Checks if there is at least one multi-region AWS CloudTrail."

  source {
    owner             = "AWS"
    source_identifier = "MULTI_REGION_CLOUD_TRAIL_ENABLED"
  }
}

resource "aws_config_config_rule" "rds-instance-deletion-protection-enabled" {
  name        = "rds-instance-deletion-protection-enabled"
  description = "Checks if an Amazon Relational Database Service (Amazon RDS) instance has deletion protection enabled."

  source {
    owner             = "AWS"
    source_identifier = "RDS_INSTANCE_DELETION_PROTECTION_ENABLED"
  }
}

resource "aws_config_config_rule" "rds-instance-public-access-check" {
  name        = "rds-instance-public-access-check"
  description = "Checks whether the Amazon Relational Database Service (RDS) instances are not publicly accessible."

  source {
    owner             = "AWS"
    source_identifier = "RDS_INSTANCE_PUBLIC_ACCESS_CHECK"
  }
}

resource "aws_config_config_rule" "rds-logging-enabled" {
  name        = "rds-logging-enabled"
  description = "Checks that respective logs of Amazon Relational Database Service (Amazon RDS) are enabled."

  source {
    owner             = "AWS"
    source_identifier = "RDS_LOGGING_ENABLED"
  }
}

resource "aws_config_config_rule" "rds-multi-az-support" {
  name        = "rds-multi-az-support"
  description = "Checks whether high availability is enabled for your RDS DB instances."

  source {
    owner             = "AWS"
    source_identifier = "RDS_MULTI_AZ_SUPPORT"
  }
}

resource "aws_config_config_rule" "rds-snapshot-encrypted" {
  name        = "rds-snapshot-encrypted"
  description = "Checks whether Amazon Relational Database Service (Amazon RDS) DB snapshots are encrypted."

  source {
    owner             = "AWS"
    source_identifier = "RDS_MULTI_AZ_SUPPORT"
  }
}

resource "aws_config_config_rule" "rds-snapshots-public-prohibited" {
  name        = "rds-snapshots-public-prohibited"
  description = "Checks if Amazon Relational Database Service (Amazon RDS) snapshots are public."

  source {
    owner             = "AWS"
    source_identifier = "RDS_SNAPSHOTS_PUBLIC_PROHIBITED"
  }
}

resource "aws_config_config_rule" "rds-storage-encrypted" {
  name        = "rds-storage-encrypted"
  description = "Checks whether storage encryption is enabled for your RDS DB instances."

  source {
    owner             = "AWS"
    source_identifier = "RDS_STORAGE_ENCRYPTED"
  }
}

resource "aws_config_config_rule" "redshift-backup-enabled" {
  name        = "redshift-backup-enabled"
  description = "Checks that Amazon Redshift automated snapshots are enabled for clusters."

  source {
    owner             = "AWS"
    source_identifier = "REDSHIFT_BACKUP_ENABLED"
  }
}

resource "aws_config_config_rule" "redshift-cluster-public-access-check" {
  name        = "redshift-cluster-public-access-check"
  description = "Checks whether Amazon Redshift clusters are not publicly accessible."

  source {
    owner             = "AWS"
    source_identifier = "REDSHIFT_CLUSTER_PUBLIC_ACCESS_CHECK"
  }
}

resource "aws_config_config_rule" "redshift-require-tls-ssl" {
  name        = "redshift-require-tls-ssl"
  description = "Checks whether Amazon Redshift clusters require TLS/SSL encryption to connect to SQL clients."

  source {
    owner             = "AWS"
    source_identifier = "REDSHIFT_REQUIRE_TLS_SSL"
  }
}

resource "aws_config_config_rule" "restricted-common-ports" {
  name        = "restricted-common-ports"
  description = "Checks if the security groups in use do not allow unrestricted incoming TCP traffic to the specified ports."

  source {
    owner             = "AWS"
    source_identifier = "RESTRICTED_INCOMING_TRAFFIC"
  }
}

resource "aws_config_config_rule" "restricted-ssh" {
  name        = "restricted-ssh"
  description = "Checks if the incoming SSH traffic for the security groups is accessible."

  source {
    owner             = "AWS"
    source_identifier = "INCOMING_SSH_DISABLED"
  }
}

resource "aws_config_config_rule" "s3-account-level-public-access-blocks" {
  name        = "s3-account-level-public-access-blocks"
  description = "Checks if the required public access block settings are configured from account level."

  source {
    owner             = "AWS"
    source_identifier = "S3_ACCOUNT_LEVEL_PUBLIC_ACCESS_BLOCKS"
  }
}

resource "aws_config_config_rule" "s3-bucket-default-lock-enabled" {
  name        = "s3-bucket-default-lock-enabled"
  description = "Checks whether Amazon S3 bucket has lock enabled, by default."

  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_DEFAULT_LOCK_ENABLED"
  }
}

resource "aws_config_config_rule" "s3-bucket-logging-enabled" {
  name        = "s3-bucket-logging-enabled"
  description = "Checks whether logging is enabled for your S3 buckets."

  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_LOGGING_ENABLED"
  }
}

resource "aws_config_config_rule" "s3-bucket-policy-grantee-check" {
  name        = "s3-bucket-policy-grantee-check"
  description = "Checks that the access granted by the Amazon S3 bucket is restricted by any of the AWS principals, federated users, service principals, IP addresses, or VPCs that you provide."

  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_POLICY_GRANTEE_CHECK"
  }
}

resource "aws_config_config_rule" "s3-bucket-public-read-prohibited" {
  name        = "s3-bucket-public-read-prohibited"
  description = "Checks if your Amazon S3 buckets do not allow public read access. The rule checks the Block Public Access settings, the bucket policy, and the bucket access control list (ACL)."

  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_PUBLIC_READ_PROHIBITED"
  }
}

resource "aws_config_config_rule" "s3-bucket-public-write-prohibited" {
  name        = "s3-bucket-public-write-prohibited"
  description = "Checks if your Amazon S3 buckets do not allow public write access. The rule checks the Block Public Access settings, the bucket policy, and the bucket access control list (ACL)."

  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_PUBLIC_WRITE_PROHIBITED"
  }
}

resource "aws_config_config_rule" "s3-bucket-replication-enabled" {
  name        = "s3-bucket-replication-enabled"
  description = "Checks if your Amazon S3 buckets have replication rules enabled."

  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_REPLICATION_ENABLED"
  }
}

resource "aws_config_config_rule" "s3-bucket-server-side-encryption-enabled" {
  name        = "s3-bucket-server-side-encryption-enabled"
  description = "Checks if your Amazon S3 bucket either has the Amazon S3 default encryption enabled or that the Amazon S3 bucket policy explicitly denies put-object requests without server side encryption that uses AES-256 or AWS Key Management Service."

  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_SERVER_SIDE_ENCRYPTION_ENABLED"
  }
}

resource "aws_config_config_rule" "s3-bucket-ssl-requests-only" {
  name        = "s3-bucket-ssl-requests-only"
  description = "Checks if Amazon S3 buckets have policies that require requests to use Secure Socket Layer (SSL)."

  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_SSL_REQUESTS_ONLY"
  }
}

resource "aws_config_config_rule" "s3-bucket-versioning-enabled" {
  name        = "s3-bucket-versioning-enabled"
  description = "Checks if versioning is enabled for your S3 buckets. Optionally, the rule checks if MFA delete is enabled for your S3 buckets."

  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_VERSIONING_ENABLED"
  }
}

resource "aws_config_config_rule" "s3-default-encryption-kms" {
  name        = "s3-default-encryption-kms"
  description = "Checks whether the Amazon S3 buckets are encrypted with AWS Key Management Service (AWS KMS)."

  source {
    owner             = "AWS"
    source_identifier = "S3_DEFAULT_ENCRYPTION_KMS"
  }
}

resource "aws_config_config_rule" "securityhub-enabled" {
  name        = "securityhub-enabled"
  description = "Checks that AWS Security Hub is enabled for an AWS Account."

  source {
    owner             = "AWS"
    source_identifier = "SECURITYHUB_ENABLED"
  }
}

resource "aws_config_config_rule" "sns-encrypted-kms" {
  name        = "sns-encrypted-kms"
  description = "Checks if Amazon SNS topic is encrypted with AWS Key Management Service (AWS KMS)."

  source {
    owner             = "AWS"
    source_identifier = "SNS_ENCRYPTED_KMS"
  }
}

resource "aws_config_config_rule" "ssm-document-not-public" {
  name        = "ssm-document-not-public"
  description = "Checks if AWS Systems Manager documents owned by the account are public."

  source {
    owner             = "AWS"
    source_identifier = "SSM_DOCUMENT_NOT_PUBLIC"
  }
}

resource "aws_config_config_rule" "vpc-default-security-group-closed" {
  name        = "vpc-default-security-group-closed"
  description = "Checks if the default security group of any Amazon Virtual Private Cloud (VPC) does not allow inbound or outbound traffic."

  source {
    owner             = "AWS"
    source_identifier = "VPC_DEFAULT_SECURITY_GROUP_CLOSED"
  }
}

resource "aws_config_config_rule" "vpc-flow-logs-enabled" {
  name        = "vpc-flow-logs-enabled"
  description = "Checks whether Amazon Virtual Private Cloud flow logs are found and enabled for Amazon VPC."

  source {
    owner             = "AWS"
    source_identifier = "VPC_FLOW_LOGS_ENABLED"
  }
}

resource "aws_config_config_rule" "vpc-sg-open-only-to-authorized-ports" {
  name        = "vpc-sg-open-only-to-authorized-ports"
  description = "Checks whether any security groups with inbound 0.0.0.0/0 have TCP or UDP ports accessible."

  source {
    owner             = "AWS"
    source_identifier = "VPC_SG_OPEN_ONLY_TO_AUTHORIZED_PORTS"
  }
}

resource "aws_config_config_rule" "required-tags" {
  name        = "data-asset-required-tags"
  description = "Checks whether S3 buckets, RDS clusters and RedShift clusters have the DataClassification and Owner tags applied"
  source {
    owner             = "AWS"
    source_identifier = "REQUIRED_TAGS"
  }
  scope {
    compliance_resource_types = ["AWS::S3::Bucket", "AWS::RDS::DBCluster", "AWS::Redshift::Cluster"]
  }
  input_parameters = "{\"tag1Key\": \"DataClassification\", \"tag2Key\": \"Owner\"}"
}
