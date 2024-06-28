variable "kubernetes_version" {
  description = "The version which we are using"
  default     = 1.27
}

variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "It is the size of the VPC"
}

variable "aws_region" {
  default     = "us-east-1"
  description = "Region in which we are creating the virtual private cloud"
}

