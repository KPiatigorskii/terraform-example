resource "aws_sqs_queue" "terraform_queue" {
  name                      = "${var.queue_name}-${var.stage}"
  delay_seconds             = var.queue_delay_seconds
  max_message_size          = var.queue_max_message_size
  message_retention_seconds = var.queue_message_retention_seconds
  receive_wait_time_seconds = var.queue_receive_wait_time_seconds
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.terraform_queue_deadletter.arn
    maxReceiveCount     = var.queue_max_receive_count
  })
}

resource "aws_sqs_queue" "terraform_queue_deadletter" {
  name = "${var.queue_name}-${var.stage}-deadletter"
  tags = {
    Environment = var.stage
  }
}