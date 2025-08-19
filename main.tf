provider "aws" {
  region = "ap-southeast-3"
}

#securitygroup using Terraform

resource "aws_security_group" "ansible-webserver-sg" {
  name        = "terraform-grafana"
  description = "Allow traffic for EC2"
  vpc_id      = "vpc-0be517bcb6881fc6a"

  ingress {
    description      = "prometheus"
    from_port        = 9090
    to_port          = 9090
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    # ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "grafana"
    from_port        = 3000
    to_port          = 3000
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    # ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "prometheus Node Exporter"
    from_port        = 9100
    to_port          = 9100
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    # ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "http"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    # ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    # ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "ansible-webserver-sg"
  }
}

resource "aws_instance" "web1" {
  ami             = "ami-0c82cd70874a842cf"
  instance_type   = "t3.micro"
  subnet_id = "subnet-049f77a69bee62037"
  vpc_security_group_ids =  [aws_security_group.ansible-webserver-sg.id]
  key_name = "webserver-apache-key"

  tags = {
    Name = "prometheus"
  }

}

resource "aws_instance" "web2" {
  ami             = "ami-0c82cd70874a842cf"
  instance_type   = "t3.micro"
  subnet_id = "subnet-049f77a69bee62037"
  vpc_security_group_ids =  [aws_security_group.ansible-webserver-sg.id]
  key_name = "webserver-apache-key"

  tags = {
    Name = "grafana"
  }

}