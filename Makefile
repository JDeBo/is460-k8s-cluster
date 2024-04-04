down:
	@terraform destroy --target aws_eks_node_group.this --auto-approve

nuke:
	@terraform destroy -auto-approve
	
up:
	@terraform apply -auto-approve -var deploy_helm=true

init:
	@terraform init
	
fmt:
	@terraform fmt -recursive
	
validate:
	@terraform validate
	
refresh:
	@aws eks update-kubeconfig --name test-eks --region us-east-1