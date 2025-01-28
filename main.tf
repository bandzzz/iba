resource "aws_vpc" "bandzzz_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "bandzzz"
  }
}

resource "aws_subnet" "subnet_a" {
  vpc_id            = aws_vpc.bandzzz_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "bandzzz-subnet-a"
  }
}

resource "aws_subnet" "subnet_b" {
  vpc_id            = aws_vpc.bandzzz_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "bandzzz-subnet-b"
  }
}
# Hello
# test
