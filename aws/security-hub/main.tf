data "aws_region" "current" {}

resource "aws_securityhub_account" "security_hub" {
  count = var.create_security_hub_resource == true ? 1 : 0
}

resource "aws_securityhub_standards_subscription" "standard" {
  for_each      = toset(var.security_hub_standards)
  standards_arn = "arn:aws-us-gov:securityhub:${data.aws_region.current.name}::${each.value}"
}
