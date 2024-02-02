resource "aws_sqs_queue" "subscriber_queue" {
  name                       = var.queue_name
  kms_master_key_id          = var.kms_key_id
  redrive_policy             = "{\"deadLetterTargetArn\":\"${aws_sqs_queue.subscriber_dl_queue.arn}\",\"maxReceiveCount\":5}"
  visibility_timeout_seconds = 300
  tags = {
    Environment = var.environment_name
  }
}

resource "aws_sqs_queue" "subscriber_dl_queue" {
  name              = var.dl_queue_name
  kms_master_key_id = var.kms_key_id
}

resource "aws_sqs_queue_policy" "subscriber_queue_policy" {
  queue_url = aws_sqs_queue.subscriber_queue.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": {
        "Service": "${var.publisher_service_url}"
      },
      "Action": "sqs:SendMessage",
      "Resource": "${aws_sqs_queue.subscriber_queue.arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${var.publisher_arn}"
        }
      }
    }
  ]
}
POLICY
}

output "queue_arn" {
  value = aws_sqs_queue.subscriber_queue.arn
}

output "queue_url" {
  value = aws_sqs_queue.subscriber_queue.url
}
