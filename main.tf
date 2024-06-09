provider "aws" {
  region = "us-east-1"
}

# Retrieve the default VPC
data "aws_vpc" "default" {
  default = true
}

# Create a security group in the default VPC
resource "aws_security_group" "ec2_sg" {
  name        = "ec2_sg"
  description = "Allow SSH and HTTP inbound traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "my_app_port"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "my_app_port"
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "my_app_port"
    from_port   = 8082
    to_port     = 8082
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "my_app_port"
    from_port   = 8083
    to_port     = 8083
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
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

# Create an ECR repository
resource "aws_ecr_repository" "my_repo" {
  name = "my-ecr-repo"
}

# Create an EC2 instance with a valid AMI ID and instance type set to t2.small
resource "aws_instance" "my_instance" {
  ami           = "ami-08c90f7460d6e8377"  # Amazon Linux 2 AMI ID for us-east-1
  instance_type = "t2.small"
  security_groups = [
    aws_security_group.ec2_sg.name
  ]

  user_data = file("./init-script.sh")

  tags = {
    Name = "MyEC2Instance"
  }
}

# Output the ECR repository URL
output "ecr_repository_url" {
  value = aws_ecr_repository.my_repo.repository_url
}

# Output the EC2 instance public IP
output "ec2_instance_public_ip" {
  value = aws_instance.my_instance.public_ip
}
