module "alb_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.2"
  create  = var.create

  name               = "${var.name}-alb-sg"
  vpc_id             = var.vpc_id
  use_name_prefix    = var.security_group_use_name_prefix
  description        = format("Security group for ALB %s", var.name)

  ingress_with_cidr_blocks = var.ingress_cidrs != [] ? [
    {
      rule        = "http-80-tcp"
      cidr_blocks = join(",", var.ingress_cidrs)
    },
    {
      rule        = "https-443-tcp"
      cidr_blocks = join(",", var.ingress_cidrs)
    }
  ] : [
    {
      rule        = "http-80-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      rule        = "https-443-tcp"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  egress_rules = ["all-all"]

  tags = merge(var.tags, {
    Name = "${var.name}-alb-sg"
  })
}

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "9.9.0"
  create  = var.create

  name               = var.name
  load_balancer_type = "application"
  vpc_id             = var.vpc_id
  subnets            = var.subnets

  listeners = {
    http-https-redirect = {
      port     = 80
      protocol = "HTTP"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
    https = {
      port     = 443
      protocol = "HTTPS"
      ssl_policy = "ELBSecurityPolicy-TLS13-1-2-FIPS-2023-04"
      certificate_arn = var.certificate_arn

      fixed_response = {
        content_type = "text/plain"
        message_body = "Page not found"
        status_code  = 200
      }
    }
  }

  create_security_group = false
  security_groups       = [module.alb_sg.security_group_id]

  access_logs                                 = var.access_logs
  connection_logs                             = var.connection_logs
  client_keep_alive                           = var.client_keep_alive
  customer_owned_ipv4_pool                    = var.customer_owned_ipv4_pool
  desync_mitigation_mode                      = var.desync_mitigation_mode # defensive is default - do we want strictest? https://docs.aws.amazon.com/securityhub/latest/userguide/elb-controls.html#elb-12
  drop_invalid_header_fields                  = var.drop_invalid_header_fields
  enable_cross_zone_load_balancing            = var.enable_cross_zone_load_balancing
  enable_deletion_protection                  = var.enable_deletion_protection
  enable_tls_version_and_cipher_suite_headers = var.enable_tls_version_and_cipher_suite_headers
  enable_xff_client_port                      = var.enable_xff_client_port
  idle_timeout                                = var.idle_timeout
  internal                                    = var.internal
  preserve_host_header                        = var.preserve_host_header
  xff_header_processing_mode                  = var.xff_header_processing_mode
  timeouts                                    = var.timeouts
  security_group_tags                         = var.security_group_tags

  tags = merge(var.tags, {
    Key = "alb-fips-enabled"
  })
}