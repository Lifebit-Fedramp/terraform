locals {
  accounts_to_share = [
    for account in var.accounts_to_share : account if account != data.aws_caller_identity.current.account_id
  ]
}