resource "aws_ecr_repository" "bandzzz_ecr_repo_202501" {
  name = "bandzzz_ecr_repo_202501"

  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
