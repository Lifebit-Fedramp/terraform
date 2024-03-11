resource "aws_networkfirewall_firewall" "firewall" {
  count               = var.enable_firewall == true ? 1 : 0
  name                = var.name
  firewall_policy_arn = aws_networkfirewall_firewall_policy.policy[0].arn
  vpc_id              = aws_vpc.main[0].id

  dynamic "subnet_mapping" {
    for_each = [
      for subnet in aws_subnet.firewall : subnet
    ]

    content {
      subnet_id = subnet_mapping.value["id"]
    }
  }
}

resource "aws_networkfirewall_firewall_policy" "policy" {
  count = var.enable_firewall == true ? 1 : 0
  name  = "${var.name}-FW-POLICY"

  firewall_policy {
    dynamic "stateful_rule_group_reference" {
      for_each = var.tls_firewall_egress_allowlist
      content {
        resource_arn = aws_networkfirewall_rule_group.rulelist[stateful_rule_group_reference.key].arn
      }
    }

    stateful_rule_group_reference {
      resource_arn = aws_networkfirewall_rule_group.aws_logging_rulelist[0].arn
    }

    stateful_rule_group_reference {
      resource_arn = aws_networkfirewall_rule_group.http_rulelist[0].arn
    }

    #stateful_rule_group_reference {
    #  resource_arn = aws_networkfirewall_rule_group.aws_regional_rulelist["<region>"].arn
    #}

    #stateful_rule_group_reference {
    #  resource_arn = aws_networkfirewall_rule_group.aws_regional_rulelist["<region>"].arn
    #}

    stateless_default_actions          = ["aws:forward_to_sfe"]
    stateless_fragment_default_actions = ["aws:forward_to_sfe"]
  }
}

resource "aws_networkfirewall_rule_group" "aws_logging_rulelist" {
  count    = var.enable_firewall == true ? 1 : 0
  capacity = 1000
  name     = "${var.name}-AWS-LOGGING-RULELIST"
  type     = "STATEFUL"

  rule_group {
    rules_source {
      stateful_rule {
        action = "ALERT"
        header {
          destination      = "ANY"
          destination_port = "ANY"
          direction        = "FORWARD"
          protocol         = "TLS"
          source           = "ANY"
          source_port      = "ANY"
        }
        rule_option {
          keyword  = "sid"
          settings = ["1"]
        }
      }
      stateful_rule {
        action = "ALERT"
        header {
          destination      = "ANY"
          destination_port = "ANY"
          direction        = "FORWARD"
          protocol         = "HTTP"
          source           = "ANY"
          source_port      = "ANY"
        }
        rule_option {
          keyword  = "sid"
          settings = ["2"]
        }
      }
    }
  }
}

/**resource "aws_networkfirewall_rule_group" "aws_regional_rulelist" {
  for_each = toset(["<region>", "<region>"])

  capacity = 3000
  name     = "${var.name}-AWS-${each.key}-RULELIST"
  type     = "STATEFUL"

  rule_group {
    rules_source {
      rules_source_list {
        generated_rules_type = "ALLOWLIST"
        target_types         = ["TLS_SNI"]

        targets = [
          ".${each.key}.compute.amazonaws.com",
          ".shield.${each.key}.amazonaws.com",
          ".access-analyzer.${each.key}.amazonaws.com",
          ".acm.${each.key}.amazonaws.com",
          ".config.${each.key}.amazonaws.com",
          ".ec2.${each.key}.amazonaws.com",
          ".guardduty.${each.key}.amazonaws.com",
          ".iot.${each.key}.amazonaws.com",
          ".kms-fips.${each.key}.amazonaws.com",
          ".s3.${each.key}.amazonaws.com",
          ".securityhub-fips.${each.key}.amazonaws.com",
          ".sts.${each.key}.amazonaws.com",
          ".access-analyzer.${each.key}.amazonaws.com",
          ".acm.${each.key}.amazonaws.com",
          ".acm-pca.${each.key}.amazonaws.com",
          ".autoscaling.${each.key}.amazonaws.com",
          ".cloudformation.${each.key}.amazonaws.com",
          ".config.${each.key}.amazonaws.com",
          "amazonlinux-2-repos-${each.key}.s3.dualstack.${each.key}.amazonaws.com",
          ".ec2.${each.key}.amazonaws.com",
          ".ec2messages.${each.key}.amazonaws.com",
          ".api.ecr.${each.key}.amazonaws.com",
          ".dkr.ecr.${each.key}.amazonaws.com",
          ".ecr-fips.${each.key}.amazonaws.com",
          ".eks.${each.key}.amazonaws.com",
          ".${each.key}.eks.amazonaws.com",
          ".elasticache.${each.key}.amazonaws.com",
          ".elasticloadbalancing.${each.key}.amazonaws.com",
          ".elasticfilesystem-fips.${each.key}.amazonaws.com",
          ".email-fips.${each.key}.amazonaws.com",
          ".events.${each.key}.amazonaws.com",
          ".guardduty.${each.key}.amazonaws.com",
          ".identitystore.${each.key}.amazonaws.com",
          ".imagebuilder.${each.key}.amazonaws.com",
          ".kms.${each.key}.amazonaws.com",
          ".kms-fips.${each.key}.amazonaws.com",
          ".lambda.${each.key}.amazonaws.com",
          ".logs.${each.key}.amazonaws.com",
          ".mq-fips.${each.key}.amazonaws.com",
          ".network-firewall-fips.${each.key}.amazonaws.com",
          ".organizations.${each.key}.amazonaws.com",
          ".ram.${each.key}.amazonaws.com",
          ".redshift.${each.key}.amazonaws.com",
          ".rds.${each.key}.amazonaws.com",
          ".s3.${each.key}.amazonaws.com",
          ".s3-fips.${each.key}.amazonaws.com",
          ".secretsmanager.${each.key}.amazonaws.com",
          ".secretsmanager-fips.${each.key}.amazonaws.com",
          ".securityhub-fips.${each.key}.amazonaws.com",
          "email-smtp-fips.${each.key}.amazonaws.com",
          ".sns.${each.key}.amazonaws.com",
          ".sqs.${each.key}.amazonaws.com",
          ".ssm.${each.key}.amazonaws.com",
          ".ssmmessages.${each.key}.amazonaws.com",
          ".sso.${each.key}.amazonaws.com",
          ".sts.${each.key}.amazonaws.com",
          ".waf-regional.${each.key}.amazonaws.com",
          ".wafv2.${each.key}.amazonaws.com",
          ".wafv2-fips.${each.key}.amazonaws.com",
        ]
      }
    }
  }
}

resource "aws_networkfirewall_rule_group" "rulelist" {
  for_each = var.tls_firewall_egress_allowlist

  capacity = 3000
  name     = "${var.name}-${replace(each.key, "_", "-")}-DOMAIN-RULELIST"
  type     = "STATEFUL"

  rule_group {
    rules_source {
      rules_source_list {
        generated_rules_type = "ALLOWLIST"
        target_types         = ["TLS_SNI"]

        targets = [
          for domain in each.value : domain.destination
        ]
      }
    }
  }
}
**/

resource "aws_networkfirewall_rule_group" "http_rulelist" {
  count    = var.enable_firewall == true ? 1 : 0
  capacity = 3000
  name     = "${var.name}-HTTP-DOMAIN-RULELIST"
  type     = "STATEFUL"

  rule_group {
    rules_source {
      rules_source_list {
        generated_rules_type = "ALLOWLIST"
        target_types         = ["HTTP_HOST"]

        targets = var.http_firewall_egress_allowlist
      }
    }
  }
}
