# Создание роли для EKS кластера
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

# Создание роли для узлов EKS
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

# Прикрепление политики к роли EKS кластера предоставляет разрешения для узлов управления EKS
resource "aws_iam_role_policy_attachment" "bandzzz_eks_worker_node_policy_202501" {
  role       = aws_iam_role.bandzzz_eks_node_role_202501.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

# Прикрепление политик к роли узлов EKS предоставляет права для работы с сетевыми интерфейсами в EKS
resource "aws_iam_role_policy_attachment" "bandzzz_eks_cni_policy_202501" {
  role       = aws_iam_role.bandzzz_eks_node_role_202501.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

# Предоставляет доступ к образам контейнеров в ECR для чтения
resource "aws_iam_role_policy_attachment" "bandzzz_ec2_container_registry_readonly_202501" {
  role       = aws_iam_role.bandzzz_eks_node_role_202501.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}
