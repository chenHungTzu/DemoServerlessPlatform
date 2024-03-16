resource "aws_ecr_repository" "ecr" {
  for_each = { for name in var.mode : name => name }
  tags     = merge(var.tags, {})
  name     = "${var.ecr_name}-${each.key}"

  provisioner "local-exec" {
    command = <<EOF
      docker pull alpine 
      EOF
  }

  provisioner "local-exec" {
    command = <<EOF
      aws ecr get-login-password --region ap-northeast-1 | docker login --username AWS --password-stdin ${data.aws_caller_identity.current.account_id}.dkr.ecr.ap-northeast-1.amazonaws.com 
      EOF
  }

  provisioner "local-exec" {
    command = <<EOF
      docker tag alpine ${self.repository_url}:latest 
      EOF
  }

  provisioner "local-exec" {
    command = <<EOF
      docker push ${self.repository_url}:latest
      EOF
  }
}