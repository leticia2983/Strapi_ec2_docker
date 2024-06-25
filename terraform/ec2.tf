resource "aws_security_group" "strapi-sg-let" {
  vpc_id      = aws_vpc.strapi_vpc.id
  description = "Security group for Strapi Application on Docker"
  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {

    from_port   = "1337"
    to_port     = "1337"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {

    from_port   = "5432"
    to_port     = "5432"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    Name = "Strapi-SG"
  }

}


resource "aws_instance" "strapi-ec2-let" {
  ami                         = var.ami
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.strapi-sg-let.id]
  subnet_id                   = aws_subnet.public_subnet1.id
  key_name                    = var.keyname
  associate_public_ip_address = true
  user_data                   = <<-EOF
                                #!/bin/bash
                                sudo apt update && sudo apt install docker.io docker-compose -y
                                sudo systemctl enable docker && sudo usermod -aG docker ubuntu
                                git clone https://github.com/leticia2983/Strapi_ec2_docker.git
                                cd Strapi_ec2_docker
                                docker-compose up -d
                                sleep 2000
                                EOF

  tags = {
    Name = "Strapi_ec2-let"
  }
}

