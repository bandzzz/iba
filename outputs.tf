# Необходимые выводы, чтобы получить информацию о созданной инфраструктуре
# Вывод инфомрациии о созданом VPC
output "vpc_id" {
  value = aws_vpc.bandzzz_vpc.id
}

# Вывод инфомрациии о созданом кластере
output "eks_cluster_name" {
  value = aws_eks_cluster.bandzzz_eks_cluster_202501.name
}

# Вывод инфомрациии о созданом ECR репозитории
output "ecr_repository_url" {
  value = aws_ecr_repository.bandzzz_ecr_repo_202501.repository_url
}


