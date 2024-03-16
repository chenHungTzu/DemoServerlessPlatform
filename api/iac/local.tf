resource "local_file" "taskfile" {
  for_each = { for name in var.mode : name => name }
  content  = <<EOF


version: "3"

tasks:
   #task --taskfile taskfile.cloud.deployment.${each.key}.yml cloud-deploy-lambda
   cloud-deploy-lambda:
    cmds:
      - aws ecr get-login-password --region ${data.aws_region.current.name} | docker login --username AWS --password-stdin ${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com
      - docker build -f ./api/Dockerfile --force-rm -t divider-ecr .
      - docker tag divider-ecr:latest ${aws_ecr_repository.ecr[each.key].repository_url}:latest
      - docker push ${aws_ecr_repository.ecr[each.key].repository_url}:latest
      - AWS_PAGER=""  aws lambda update-function-code --function-name ${aws_lambda_function.lambda[each.key].arn} --image-uri ${aws_ecr_repository.ecr[each.key].repository_url}:latest
    desc: "[cloud] 上傳並更新Lambda"
  EOF
  filename = "../../taskfile.cloud.deployment.${each.key}.yml"
}