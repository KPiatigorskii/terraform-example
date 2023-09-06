variable "table_name" {
  description = "Name of the DynamoDB table"
  type        = string
  default = "Events"
}

variable "billing_mode" {
  description = "Billing mode for the DynamoDB table (PROVISIONED or PAY_PER_REQUEST)"
  type        = string
  default = "PROVISIONED"
}

variable "read_capacity" {
  description = "Read capacity units for the DynamoDB table (if using PROVISIONED billing mode)"
  type        = number
  default = 30
}

variable "write_capacity" {
  description = "Write capacity units for the DynamoDB table (if using PROVISIONED billing mode)"
  type        = number
  default = 30
}

variable "hash_key_name" {
  description = "Name of the hash key attribute"
  type        = string
  default = "noteId"
}

variable "hash_key_type" {
  description = "Data type of the hash key attribute"
  type        = string
  default = "S"
}

variable "stage" { }

variable "terraform_locks_name" {
  default = "terraform-up-and-running-locks"
}