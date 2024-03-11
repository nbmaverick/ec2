# Security Group

resource "aws_security_group" "ec2" {
  name        = "ec2_security_group"
  description = "Controls access to the EC2"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
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

# EC2 instances

resource "aws_instance" "bastion" {
  ami           = "ami-0f403e3180720dd7e"
  instance_type = "t2.micro"
  associate_public_ip_address = true
  availability_zone = "us-east-1a"
  key_name = "laptop"
  security_groups = [aws_security_group.ec2.id]
  subnet_id = aws_subnet.public1.id 
  user_data = file("shell.sh")

  tags = {
    Name = "Bastion"
  }
}

# resource "aws_key_pair" "bastion" {
#   key_name   = "bastion-key"
#   public_key = ""             # add key from bastion key
# }

# resource "aws_instance" "database" {
#   ami           = "ami-0f403e3180720dd7e"
#   instance_type = "t2.micro"
#   associate_public_ip_address = false
#   availability_zone = "us-east-1a"
#   key_name = "laptop"
#   security_groups = [aws_security_group.ec2.id]
#   subnet_id = aws_subnet.private1.id 
  
#   tags = {
#     Name = "Database"
#   }
# }
