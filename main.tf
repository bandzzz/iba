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

resource "aws_ecr_repository" "bandzzz_repository" {
  name = "bandzzz-ecr-repo"
}

resource "aws_iam_role" "bandzzz_eks_cluster_role" {
  name = "bandzzz-eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "eks.amazonaws.com"
        }
        Effect = "Allow"
        Sid    = ""
      },
    ]
  })
}

resource "aws_eks_cluster" "bandzzz_cluster" {
  name     = "bandzzz-cluster"
  role_arn = aws_iam_role.bandzzz_eks_cluster_role.arn

  vpc_config {
    subnet_ids = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]
  }

  depends_on = [aws_iam_role.bandzzz_eks_cluster_role]
}

resource "aws_iam_role" "bandzzz_eks_node_role" {
  name = "bandzzz-eks-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Effect = "Allow"
        Sid    = ""
      },
    ]
  })
}
resource "aws_eks_node_group" "bandzzz_node_group" {
  cluster_name    = aws_eks_cluster.bandzzz_cluster.name
  node_group_name = "bandzzz-node-group"
  node_role_arn   = aws_iam_role.bandzzz_eks_node_role.arn
  subnet_ids      = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]
  instance_types  = ["t3.micro"]

  tags = {
    Name = "bandzzz-node-group"
  }
  scaling_config {
    desired_size = 2
    min_size     = 1
    max_size     = 3
  }
  depends_on = [aws_eks_cluster.bandzzz_cluster]
}

