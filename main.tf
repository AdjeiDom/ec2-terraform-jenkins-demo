resource "aws_vpc" "my_vpc-EC2" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "my_vpc-EC2"
  }
}

resource "aws_subnet" "ec2-sub1-priv" {
  vpc_id            = aws_vpc.my_vpc-EC2.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-2a"

  tags = {
    Name = "ec2-sub1-priv"
  }
}

resource "aws_subnet" "ec2-sub2-pub" {
  vpc_id            = aws_vpc.my_vpc-EC2.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-west-2b"

  tags = {
    Name = "ec2-sub2-pub"
  }
}

resource "aws_network_interface" "prime_netwk_interface" {
  subnet_id   = aws_subnet.ec2-sub2-pub.id
  
  tags = {
    Name = "prime_netwk_interface"
  }
}

resource "aws_instance" "ec2-terraform-demo" {
  ami           = "ami-00950d2c99bfd49a6" # eu-west-2
  instance_type = "t2.micro"

  /* network_interface {
    network_interface_id = "aws_network_interface.prime_netwk_interface.id"
    device_index         = 0
  } */
  credit_specification {
    cpu_credits = "unlimited"
  }
}
