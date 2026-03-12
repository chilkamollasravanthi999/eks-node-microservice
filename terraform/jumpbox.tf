resource "aws_instance" "jumpbox" {

  ami           = "ami-0c7217cdde317cfec"
  instance_type = "t3.micro"

  subnet_id = module.vpc.public_subnets[0]

  key_name = "eks-key"

  vpc_security_group_ids = [
    aws_security_group.jumpbox_sg.id
  ]

  tags = {
    Name = "eks-jumpbox"
  }
}

resource "aws_security_group" "jumpbox_sg" {

  name   = "jumpbox-sg"
  vpc_id = module.vpc.vpc_id

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