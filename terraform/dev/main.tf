terraform {
  required_version = ">= 1.5.3"

  backend "s3" {
    bucket         = "shoshone-tfstate"
    key            = "shoshonekey/atlantis"
    region         = "us-east-1"
    kms_key_id     = "arn:aws:kms:us-east-1:520291287938:key/4fc9e509-04c4-4881-89e7-46fb49790093"
    dynamodb_table = "shoshone-state-lock"
  }
}

resource "aws_instance" "myec2vm" {
  ami           = data.aws_ami.amzlinux2.id
# cool loops
#   instance_type = var.instance_type
  instance_type = var.instance_type_list[1]
#   instance_type = var.instance_type_map["dev"]
  user_data     = file("${path.module}/app1-install.sh")
  key_name      = var.instance_keypair
  vpc_security_group_ids = [
    aws_security_group.vpc-ssh.id,
    aws_security_group.vpc-web.id
  ]
  count = 1
  tags = {
    "Name" = "Atlantis_Eval_Count_${count.index}"
  }
}

resource "aws_security_group" "vpc-ssh" {
  name        = "vpc-ssh"
  description = "Dev VPC SSH"

  ingress {
    description = "Allow Port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all ports outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "vpc-ssh"
  }
}

resource "aws_security_group" "vpc-web" {
  name        = "vpc-web"
  description = "Dev VPC SSH"

  ingress {
    description = "Allow Port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow Port 443"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all ports outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "vpc-web"
  }
}

resource "aws_s3_bucket" "atlantis" {
  bucket = "atlantisTesting"

  tags = {
    Name        = "atlantisTesting"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.atlantis.id
  acl    = "private"
}