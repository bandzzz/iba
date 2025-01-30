# Создание кластера Amazon EKS + роли IAM для кластера
resource "aws_eks_cluster" "bandzzz_eks_cluster_202501" {
  name     = var.cluster_name
  role_arn = aws_iam_role.bandzzz_eks_cluster_role_202501.arn

  vpc_config {
    subnet_ids = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.bandzzz_eks_cluster_policy_202501,
  ]
}

# Создание группы узлов для кластера EKS + роли IAM для узлов
resource "aws_eks_node_group" "bandzzz_eks_node_group_202501" {
  cluster_name    = aws_eks_cluster.bandzzz_eks_cluster_202501.name
  node_group_name = "bandzzz_eks_node_group_202501"
  node_role_arn   = aws_iam_role.bandzzz_eks_node_role_202501.arn
  subnet_ids      = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]

  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 2
  }

  instance_types = [var.node_instance_type]

# Определяее зависимости, что необходимые политики IAM присоединены к ролям
  depends_on = [
    aws_iam_role_policy_attachment.bandzzz_eks_worker_node_policy_202501,
    aws_iam_role_policy_attachment.bandzzz_eks_cni_policy_202501,
    aws_iam_role_policy_attachment.bandzzz_ec2_container_registry_readonly_202501,
  ]
}
