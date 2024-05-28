resource "aws_ssm_parameter" "parameter" {
  for_each    = { for k, v in var.ssm_parameters : k => v }
  name        = "${var.path_prefix}/${each.key}"
  description = each.value.description
  type        = each.value.value != "" ? "String" : "SecureString"
  value       = each.value.value
  key_id      = each.value.value != "" ? null : var.key_id

  tags = var.tags
}

resource "aws_iam_policy" "read_parameters" {
  name = "read-${var.identifier}-ssm-params"
  description = "IAM policy for read access to the ${var.identifier} SSM Parameters"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ssm:DescribeParameters"
        ],
        Resource = ["*"]
      },
      {
        Effect = "Allow"
        Action = [
          "ssm:GetParameters"
        ],
        Resource = [
          values(aws_ssm_parameter.parameter)[*].arn
        ]
      }
    ]
  })
}