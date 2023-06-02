provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region = var.aws_region
}

/* Template of how to deploy an EC2 instance on each AZ
resource "aws_instance" "ec2_instances" {
  count         = length(var.subnet_cidr_blocks)
  ami           = "ami-03aefa83246f44ef2"  # Replace with your desired AMI ID
  instance_type = "t2.micro"
  subnet_id     = module.network.subnets[count.index].id

*/
/*
#Optional management machine to help test and debug networking stuff within VPC  
resource "aws_instance" "almog-mgmt" {
  ami           = "ami-03aefa83246f44ef2"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet[1].id
  vpc_security_group_ids = [aws_default_security_group.default.id]
  associate_public_ip_address = true
  key_name = "alon_ec2"
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install docker -y
              sudo service docker start
              sudo usermod -aG docker ec2-user
              sudo docker run -d --name DinoHelloWorld -p 80:80 litetex/t-rex-runner
              EOF
  }
*/