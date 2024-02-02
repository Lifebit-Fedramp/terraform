resource "random_id" "id" {
  byte_length = 8
}

# initial password
resource "random_password" "mq" {
  length  = 16
  special = false
}

resource "aws_secretsmanager_secret" "mq-credentials" {
  name        = "${var.name}-credentials-${random_id.id.hex}"
  description = "Amazon MQ credentials for ${var.name}"
}

resource "aws_secretsmanager_secret_version" "mq-credentials" {
  secret_id = aws_secretsmanager_secret.mq-credentials.id
  secret_string = jsonencode(
    {
      username = var.broker_user
      password = random_password.mq.result
    }
  )
}

resource "aws_secretsmanager_secret" "mq-uri" {
  name        = "${var.name}-mq-uri-${random_id.id.hex}"
  description = "Amazon MQ credentials for ${var.name}"
}

resource "aws_secretsmanager_secret_version" "mq-uri" {
  secret_id = aws_secretsmanager_secret.mq-uri.id
  secret_string = jsonencode(
    {
      mq_url = "amqps://${var.broker_user}:${random_password.mq.result}@${replace(aws_mq_broker.broker.instances.0.endpoints.0, "amqps://", "")}"
    }
  )
}
