variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "eu-central-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

variable access_key {}
variable secret_key {}

