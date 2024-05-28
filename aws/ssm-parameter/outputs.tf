output "parameters" {
  description = "Map of Parameters created"
  value       = aws_ssm_parameter.parameter
}

output "parameters_policy" {
  description = "Read access IAM policy for the parameters"
  value       = aws_iam_policy.read_parameters
}