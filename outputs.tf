output "vpc_id" {
  value = aws_vpc.bandzzz_vpc.id
}
output "ecr_repository_url" {
  value = aws_ecr_repository.bandzzz_ecr_repo_202501.repository_url
}


