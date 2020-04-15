provider "aws" {
  region     = "us-east-1"
}
resource "aws_instance" "example" {

  ami="ami-07ebfd5b3428b6f4d"
  instance_type = "t2.micro"
  iam_instance_profile = "${aws_iam_instance_profile.ec2_profile.name}"
  subnet_id= "subnet-02781885e8b26ae1f"
  vpc_security_group_ids=["sg-07c59511eb27de520"]
  user_data = "${file("install_apache.sh")}"
}

resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
}

resource "aws_subnet" "us-east-1b-public" {
  vpc_id = "${aws_vpc.example.id}"
  cidr_block = "10.0.1.0/25"
  availability_zone = "us-east-1b"
}
