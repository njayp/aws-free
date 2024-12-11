variable "region" {
  type        = string
  description = "The project region"
  default     = "us-west-1"
}

variable "ami" {
  type        = string
  description = "The machine image"
  default     = "ami-038bba9a164eb3dc1" # Amazon Linux in us-w-1
}

variable "name" {
  type        = string
  description = "The name for the EC2 instance"
  default     = "Terraform-Instance"
}

variable "instance_type" {
  type        = string
  description = "EC2 Instance Type"
  default     = "t2.micro"
}

