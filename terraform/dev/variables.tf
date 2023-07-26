variable "aws_region" {
  description = "Region in which AWS recources to create"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "instance_keypair" {
  description = "AWS EC2 Keypair"
  type        = string
  default     = "terraform-key"
}

variable "instance_type_list" {
  description = "EC2 instance type list"
  type        = list(string)
  default     = ["t3.micro", "t3.small", "t3.large"]
}

variable "instance_type_map" {
  description = "Ec2 instance type map"
  type        = map(string)
  default = {
    "dev"  = "t3.micro"
    "qa"   = "t3.small"
    "prod" = "t3.medium"
  }
}