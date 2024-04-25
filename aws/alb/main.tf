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
      #      certificate_arn = var.certificate_arn

      fixed_response = {
        content_type = "text/plain"
        message_body = "Page not found"
        status_code  = 200
      }
    }
  }

  security_group_name            = "${var.name}-alb-sg"
  security_group_use_name_prefix = var.security_group_use_name_prefix
  security_group_description     = format("Security group for ALB %s", var.name)
  security_group_ingress_rules = var.private_ingress_sg_rules == {} ? {
    all_https = {
      from_port = 443
      to_port   = 443
      protocol  = "tcp"
      cidr_ipv4 = "0.0.0.0/0"
    }
    all_http = {
      from_port = 80
      to_port   = 80
      protocol  = "tcp"
      cidr_ipv4 = "0.0.0.0/0"
    }
  } : var.private_ingress_sg_rules
  security_group_egress_rules = {
    all = {
      ip_protocol = "-1"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }

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