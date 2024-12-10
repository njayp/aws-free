# Define the AWS provider
provider "aws" {
  region = "us-west-1" # Change this to your preferred region
}

# Generate a key pair
resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "generated" {
  key_name   = "my-key-pair"
  public_key = tls_private_key.example.public_key_openssh
}

# Create a security group allowing SSH access
resource "aws_security_group" "allow_ssh" {
  name_prefix = "allow-ssh"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an EC2 instance
resource "aws_instance" "example" {
  ami           = "ami-038bba9a164eb3dc1" # Amazon Linux
  instance_type = "t2.micro"

  key_name               = aws_key_pair.generated.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "Terraform-Instance"
  }
}

# saves key to file
resource "local_file" "private_key" {
  content  = tls_private_key.example.private_key_pem
  filename = "private_key.pem"
}

# saves ip to state
output "instance_public_ip" {
  value = aws_instance.example.public_ip
}


