resource "aws_vpc" "bandzzz_vpc_202501" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "bandzzz_vpc_202501"
  }
}

resource "aws_subnet" "bandzzz_subnet_202501" {
  count             = 2
  vpc_id            = aws_vpc.bandzzz_vpc_202501.id
  cidr_block        = cidrsubnet(aws_vpc.bandzzz_vpc_202501.cidr_block, 4, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "bandzzz-subnet-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "bandzzz_igw_202501" {
  vpc_id = aws_vpc.bandzzz_vpc_202501.id

  tags = {
    Name = "bandzzz_igw_202501"
  }
}

resource "aws_route_table" "bandzzz_route_table_202501" {
  vpc_id = aws_vpc.bandzzz_vpc_202501.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.bandzzz_igw_202501.id
  }

  tags = {
    Name = "bandzzz_route_table_202501"
  }
}

resource "aws_route_table_association" "bandzzz_route_assoc_202501" {
  count          = 2
  subnet_id      = aws_subnet.bandzzz_subnet_202501[count.index].id
  route_table_id = aws_route_table.bandzzz_route_table_202501.id
}
