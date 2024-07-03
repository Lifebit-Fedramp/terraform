data "aws_region" "this" {}

resource "aws_ses_domain_identity" "this" {
  domain = var.domain
}

resource "aws_ses_domain_dkim" "ses_domain_dkim" {
  domain = join("", aws_ses_domain_identity.this.*.domain)
}

resource "aws_ses_domain_mail_from" "this" {
  domain           = aws_ses_domain_identity.this.domain
  mail_from_domain = "bounce.${aws_ses_domain_identity.this.domain}"
}

module "ses_kms_key" {
  source = "terraform-aws-modules/kms/aws"

  description = "ses s3 kms key"
  key_usage   = "ENCRYPT_DECRYPT"

  enable_key_rotation = true

  key_statements = [
    {
      sid = "SES"
      actions = [
        "kms:Encrypt*",
        "kms:Decrypt*",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*",
        "kms:Describe*"
      ]
      resources = ["*"]

      principals = [
        {
          type        = "Service"
          identifiers = ["ses.amazonaws.com"]
        }
      ]
    }
  ]
}

resource "aws_sns_topic" "this" {
  name              = replace("sns-smtp-${var.domain}", ".", "-")
  kms_master_key_id = module.ses_kms_key.key_id
}

resource "aws_ses_configuration_set" "this" {
  name = replace("${var.domain}-configuration-set", ".", "-")

  delivery_options {
    tls_policy = "Require"
  }
}

resource "aws_ses_event_destination" "sns" {
  name                   = replace("event-destination-sns-${var.domain}", ".", "-")
  configuration_set_name = aws_ses_configuration_set.this.name
  enabled                = true
  matching_types         = ["bounce", "delivery", "complaint"]

  sns_destination {
    topic_arn = aws_sns_topic.this.arn
  }
}

# NOTE: This will probably fail unless you can setup DNS records quickly enough
# May require setting up twice, once to create the domain identity, then again to verify it.
resource "aws_ses_domain_identity_verification" "example_verification" {
  domain = aws_ses_domain_identity.this.id
}

data "aws_iam_policy_document" "this" {
  statement {
    actions = [
      "ses:SendEmail",
      "ses:SendRawEmail",
    ]
    resources = aws_ses_domain_identity.this.*.arn
  }
}

resource "aws_iam_group" "this" {
  name = "<iam_group>"
  path = "/ses/"
}

resource "aws_iam_group_policy" "this" {
  name  = "ses-group-policy"
  group = aws_iam_group.this.name

  policy = data.aws_iam_policy_document.this.json
}

resource "aws_iam_user_group_membership" "this" {
  user = module.ses_user.name

  groups = [
    aws_iam_group.this.name
  ]
}

module "ses_user" {
  source  = "<ses_user>"
  version = "2.0.1"

  name = "ses-user-${var.domain}"
}

module "aws-secrets-manager-secret" {
  source  = "<secret>"
  version = "1.0.1"

  # Required inputs
  name = "ses-${var.domain}"
}

resource "aws_secretsmanager_secret_version" "this" {
  secret_id = module.aws-secrets-manager-secret.secret_id
  secret_string = jsonencode({
    username          = module.ses_user.active.id
    password          = module.ses_user.active.ses_smtp_password_v4
    relay             = "email-smtp.${data.aws_region.this.name}.amazonaws.com"
    fips_relay        = "email-smtp-fips.${data.aws_region.this.name}.amazonaws.com"
    STARTTLS_port     = ["25", "587", "2587"]
    TLS_wrapper_port  = ["465", "2465"]
    identity          = var.domain,
    bounced_email_sns = aws_sns_topic.this.arn
  })
}
