# Создание VPC
resource "aws_vpc" "bandzzz_vpc" { 
  cidr_block           = "10.0.0.0/16" 
  enable_dns_support   = true 
  enable_dns_hostnames = true 
  tags = { 
    Name = "bandzzz" 
  } 
} 

# Cоздание подсетей subnet
resource "aws_subnet" "subnet_a" { 
  vpc_id            = aws_vpc.bandzzz_vpc.id 
  cidr_block        = "10.0.1.0/24" 
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a" 
  tags = { 
    Name = "bandzzz-subnet-a" 
  } 
} 

# Cоздание подсетей subnet
resource "aws_subnet" "subnet_b" { 
  vpc_id            = aws_vpc.bandzzz_vpc.id 
  cidr_block        = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1b" 
  tags = { 
    Name = "bandzzz-subnet-b" 
  } 
}

# Создание интернет-шлюза IGW
resource "aws_internet_gateway" "bandzzz_igw_202501" {
  vpc_id = aws_vpc.bandzzz_vpc.id

  tags = {
    Name = "bandzzz_igw_202501"
  }
}

# Создание таблицы маршрутизации
resource "aws_route_table" "bandzzz_route_table_202501" {
  vpc_id = aws_vpc.bandzzz_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.bandzzz_igw_202501.id
  }

  tags = {
    Name = "bandzzz_route_table_202501"
  }
}

# Ассоциация таблицы маршрутов с подсетями
resource "aws_route_table_association" "bandzzz_route_assoc_202501" {
  count          = 2
  subnet_id      = element([aws_subnet.subnet_a.id, aws_subnet.subnet_b.id], count.index)
  route_table_id = aws_route_table.bandzzz_route_table_202501.id
}
