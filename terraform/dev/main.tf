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
#   instance_type = var.instance_type
#   instance_type = var.instance_type_list[1]
  instance_type = var.instance_type_map["dev"]
  user_data     = file("${path.module}/app1-install.sh")
  key_name      = var.instance_keypair
  vpc_security_group_ids = [
    aws_security_group.vpc-ssh.id,
    aws_security_group.vpc-web.id
  ]
  count = 3
  tags = {
    "Name" = "Atlantis_Eval_Count_${count.index}"
  }
}