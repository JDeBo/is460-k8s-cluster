down:
	@terraform destroy -auto-approve
	
up:
	@terraform apply -auto-approve

init:
	@terraform init
	
fmt:
	@terraform fmt -recursive
	
validate:
	@terraform validate
	
refresh:
	@aws eks update-kubeconfig --name test-eks --region us-east-1