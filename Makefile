down:
	@terraform destroy --target aws_eks_node_group.this --auto-approve

nuke:
	@terraform -chdir=modules/helm destroy -auto-approve
	@terraform destroy -auto-approve
	
up:
	@terraform apply -auto-approve
	@terraform -chdir=modules/helm apply -auto-approve

init:
	@./init.sh
	@terraform init
	@terraform -chdir=modules/helm init

	
fmt:
	@terraform fmt -recursive
	
validate:
	@terraform validate
	
refresh:
	@aws eks update-kubeconfig --name test-eks --region us-east-1