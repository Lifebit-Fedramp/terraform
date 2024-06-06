resource "aws_ssm_parameter" "parameter" {
  for_each    = { for k, v in var.ssm_parameters : k => v }
  name        = "/${var.environment}/${var.path_prefix}/${each.key}"
  description = each.value.description
  type        = each.value.value != "" ? "String" : "SecureString"
  value       = each.value.value != "" ? each.value.value : "<placeholder>"
  key_id      = each.value.value != "" ? null : var.key_id

  tags = var.tags

  lifecycle {
    ignore_changes = [value]
  }
}