variable "stage" {}

variable "queue_name" {
  description = "Name of the SQS queue"
  type        = string
  default     = "terraform-offra-queue"
}

variable "queue_delay_seconds" {
  description = "Delay in seconds for messages in the queue"
  type        = number
  default     = 90
}

variable "queue_max_message_size" {
  description = "Maximum message size in bytes"
  type        = number
  default     = 2048
}

variable "queue_message_retention_seconds" {
  description = "Message retention time in seconds"
  type        = number
  default     = 86400
}

variable "queue_receive_wait_time_seconds" {
  description = "Time in seconds that the ReceiveMessage action waits for a message to arrive"
  type        = number
  default     = 10
}

variable "queue_max_receive_count" {
  description = "Maximum number of receives before moving to the dead-letter queue"
  type        = number
  default     = 4
}