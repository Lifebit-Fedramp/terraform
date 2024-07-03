output "domain_verification_token" {
  value = aws_ses_domain_identity.this.*.verification_token
}

output "dkim_tokens" {
  value = aws_ses_domain_dkim.ses_domain_dkim.*.dkim_tokens
}
