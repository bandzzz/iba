resource "aws_iam_role" "bandzzz_eks_cluster_role_202501" {
  name = "bandzzz_eks_cluster_role_202501"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "bandzzz_eks_cluster_policy_202501" {
  role       = aws_iam_role.bandzzz_eks_cluster_role_202501.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "bandzzz_eks_service_policy_202501" {
  role       = aws_iam_role.bandzzz_eks_cluster_role_202501.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
}

resource "aws_iam_role" "bandzzz_eks_node_role_202501" {
  name = "bandzzz_eks_node_role_202501"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "bandzzz_eks_worker_node_policy_202501" {
  role       = aws_iam_role.bandzzz_eks_node_role_202501.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "bandzzz_eks_cni_policy_202501" {
  role       = aws_iam_role.bandzzz_eks_node_role_202501.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "bandzzz_ec2_container_registry_readonly_202501" {
  role       = aws_iam_role.bandzzz_eks_node_role_202501.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}
