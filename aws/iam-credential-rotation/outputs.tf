output "active" {
  value = local.BG[rotating_blue_green.this.active]
}

output "blue" {
  value = aws_iam_access_key.blue
}

output "green" {
  value = aws_iam_access_key.green
}

output "name" {
  value = aws_iam_user.this.name
}

output "arn" {
  value = aws_iam_user.this.arn
}