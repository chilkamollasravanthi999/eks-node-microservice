resource "aws_security_group" "jumpbox_sg" {

  name   = "jumpbox-sg"
  vpc_id = aws_vpc.dev_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "jumpbox-sg"
  }
}

resource "aws_instance" "jumpbox" {

  ami           = "ami-03f4878755434977f"
  instance_type = "t2.micro"

  subnet_id = aws_subnet.public_subnet1.id

  vpc_security_group_ids = [
    aws_security_group.jumpbox_sg.id
  ]

  iam_instance_profile = aws_iam_instance_profile.jumpbox_profile.name

  associate_public_ip_address = true

  tags = {
    Name = "eks-jumpbox"
  }
}