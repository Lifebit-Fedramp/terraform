data "aws_caller_identity" "current" {}

resource "aws_wafv2_web_acl" "default" {
  name        = var.name
  description = var.description
  scope       = "REGIONAL"

  default_action {
    allow {} #set to block {} if using geoblock statement to allow traffic from specific geolocations and block all others
  }

  # rule-01: AWSManagedRulesAmazonIpReputationList
  # "This group contains rules that are based on Amazon threat intelligence. This is useful if you would like to block sources associated with bots or other threats."
  rule {
    name     = "rule-01-AWSManagedRulesAmazonIpReputationList"
    priority = 10

    override_action {
      none {} # set to none {} to undo override when enforcing, set to count {} to disable enforcement
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesAmazonIpReputationList"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "AWSManagedRulesAmazonIpReputationList"
      sampled_requests_enabled   = false
    }
  }

  # rule-02: AWSManagedRulesAnonymousIpList
  # "This group contains rules that allow you to block requests from services that allow obfuscation of viewer identity. This can include request originating from VPN, proxies, Tor nodes, and hosting providers. This is useful if you want to filter out viewers that may be trying to hide their identity from your application."
  rule {
    name     = "rule-02-AWSManagedRulesAnonymousIpList"
    priority = 20

    override_action {
      none {} # set to none {} to undo override when enforcing, set to count {} to disable enforcement
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesAnonymousIpList"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "AWSManagedRulesAnonymousIpList"
      sampled_requests_enabled   = false
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = var.name
    sampled_requests_enabled   = false
  }

  # rule-03: AWSManagedRulesCommonRuleSet
  # "Contains rules that are generally applicable to web applications. This provides protection against exploitation of a wide range of vulnerabilities, including those described in OWASP publications."
  rule {
    name     = "rule-03-AWSManagedCommonRuleSet"
    priority = 30

    override_action {
      count {} # set to none {} to undo override when enforcing, set to count {} to disable enforcement
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "AWSManagedRulesCommonRuleSet"
      sampled_requests_enabled   = false
    }
  }

  # rule-04: AWSManagedRulesSQLiRuleSet
  # "Contains rules that allow you to block request patterns associated with exploitation of SQL databases, like SQL injection attacks. This can help prevent remote injection of unauthorized queries."
  rule {
    name     = "rule-04-AWSManagedRulesSQLiRuleSet"
    priority = 40

    override_action {
      none {} # set to none {} to undo override when enforcing, set to count {} to disable enforcement
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesSQLiRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "AWSManagedRulesSQLiRuleSet"
      sampled_requests_enabled   = false
    }
  }

  # rule-05: AWSManagedRulesLinuxRuleSet
  # "Contains rules that block request patterns associated with exploitation of vulnerabilities specific to Linux, including LFI attacks. This can help prevent attacks that expose file contents or execute code for which the attacker should not have had access."
  rule {
    name     = "rule-05-AWSManagedRulesLinuxRuleSet"
    priority = 50

    override_action {
      none {} # set to none {} to undo override when enforcing, set to count {} to disable enforcement
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesLinuxRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "AWSManagedRulesLinuxRuleSet"
      sampled_requests_enabled   = false
    }
  }

  # rule-06: AWSManagedRulesPHPRuleSet
  # "Contains rules that block request patterns associated with exploiting vulnerabilities specific to the use of the PHP, including injection of unsafe PHP functions. This can help prevent exploits that allow an attacker to remotely execute code or commands."
  rule {
    name     = "rule-06-AWSManagedRulesPHPRuleSet"
    priority = 60

    override_action {
      none {} # set to none {} to undo override when enforcing, set to count {} to disable enforcement
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesPHPRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "AWSManagedRulesPHPRuleSet"
      sampled_requests_enabled   = false
    }
  }

  # rule-07: AWSManagedRulesKnownBadInputsRuleSet
  # "Contains rules that block request patterns associated with exploiting vulnerabilities specific to the use of the PHP, including injection of unsafe PHP functions. This can help prevent exploits that allow an attacker to remotely execute code or commands."
  rule {
    name     = "rule-07-AWSManagedRulesKnownBadInputsRuleSet"
    priority = 70

    override_action {
      none {} # set to none {} to undo override when enforcing, set to count {} to disable enforcement
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesKnownBadInputsRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "AWSManagedRulesKnownBadInputsRuleSet"
      sampled_requests_enabled   = false
    }
  }

  # rule-08: AWSHTTPFloodProtection
  # "A blanket rate-based rule to protect your application from large HTTP floods.""
  rule {
    name     = "rule-08-AWSHTTPFloodProtection"
    priority = 80

    action {
      block {} # set to none {} to undo override when enforcing, set to count {} to disable enforcement
    }

    statement {
      rate_based_statement {
        limit              = 10000
        aggregate_key_type = "IP"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "AWSHTTPFloodProtection"
      sampled_requests_enabled   = false
    }
  }

  # rule-09: AWSSpecificURIHTTPFloodProtection
  # "A rate-based rule protects specific URIs at more restrictive rates than a blanket rate-based rule."
  rule {
    name     = "rule-09-AWSSpecificURIHTTPFloodProtection"
    priority = 90

    action {
      block {} # set to none {} to undo override when enforcing, set to count {} to disable enforcement
    }

    statement {
      rate_based_statement {
        limit              = 2000
        aggregate_key_type = "IP"

        scope_down_statement {
          or_statement {
            statement {
              byte_match_statement {
                search_string = "/login" #URI match needs updating once defined
                field_to_match {
                  uri_path {}
                }
                text_transformation {
                  priority = 0
                  type     = "NONE"
                }
                positional_constraint = "CONTAINS"
              }
            }
            statement {
              byte_match_statement {
                search_string = "/admin" #URI match needs updating once defined
                field_to_match {
                  uri_path {}
                }
                text_transformation {
                  priority = 0
                  type     = "NONE"
                }
                positional_constraint = "CONTAINS"
              }
            }
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "AWSHTTPFloodProtection"
      sampled_requests_enabled   = false
    }
  }

  # rule-10: AWSGeoBlockStatements
  # "Allows trusted geo-locations. All others blocked via default_action"
  rule {
    name     = "rule-10-AWSGeoBlockStatements"
    priority = 100

    action {
      allow {}
    }

    statement {
      geo_match_statement {
        country_codes = ["US"]
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "AWSGeoBlockStatements"
      sampled_requests_enabled   = false
    }
  }

  # rule-11: allow specific ip addresses
  # "Allows specific IP addresses. All others blocked via default_action"
  dynamic "rule" {
    for_each = length(var.allowed_ips) > 0 ? ["enabled"] : []
    content {
      name     = "rule-11-allow-specific-ip-addresses"
      priority = 110

      action {
        allow {}
      }

      statement {
        ip_set_reference_statement {
          arn = aws_wafv2_ip_set.allow_specific_ip_addresses[rule.key].arn
        }
      }

      visibility_config {
        cloudwatch_metrics_enabled = false
        metric_name                = "allow_specific_ip_addresses"
        sampled_requests_enabled   = false
      }
    }
  }
}

resource "aws_wafv2_ip_set" "allow_specific_ip_addresses" {
  count              = length(var.allowed_ips) > 0 ? 1 : 0
  name               = "allow_specific_ip_addresses"
  description        = "Allow specific IP addresses"
  scope              = "REGIONAL"
  ip_address_version = "IPV4"
  addresses          = var.allowed_ips
}

resource "aws_kms_key" "wafv2default" {
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Id" : "key-default-1",
    "Statement" : [
      {
        "Sid" : "Enable IAM User Permissions",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws-us-gov:iam::${data.aws_caller_identity.current.account_id}:root"
        },
        "Action" : "kms:*",
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "logs.us-gov-west-1.amazonaws.com"
        },
        "Action" : [
          "kms:Encrypt*",
          "kms:Decrypt*",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:Describe*"
        ],
        "Resource" : "*",
        "Condition" : {
          "ArnEquals" : {
            "kms:EncryptionContext:aws:logs:arn" : "arn:aws-us-gov:logs:us-gov-west-1:${data.aws_caller_identity.current.account_id}:log-group:*"
          }
        }
      }
    ]
  })
  tags = {
    "Name" : "<org>-cloudwatchlogs-wafv2"
  }
}

resource "aws_cloudwatch_log_group" "wafv2default" {
  name              = "aws-waf-logs-waf/${var.name}"
  retention_in_days = 365
  kms_key_id        = aws_kms_key.wafv2default.arn
  depends_on        = [aws_kms_key.wafv2default]
}

resource "aws_wafv2_web_acl_logging_configuration" "default" {
  log_destination_configs = [aws_cloudwatch_log_group.wafv2default.arn]
  resource_arn            = aws_wafv2_web_acl.default.arn
  depends_on              = [aws_cloudwatch_log_group.wafv2default]
}
