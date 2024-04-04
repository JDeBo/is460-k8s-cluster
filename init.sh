#!/bin/bash

# Function to install AWS CLI
install_aws_cli() {
    echo "Installing AWS CLI..."
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
    rm -rf awscliv2.zip ./aws
}

# Function to install Terraform
install_terraform() {
    echo "Installing Terraform..."
    sudo yum install -y yum-utils
    sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
    sudo yum -y install terraform
}

# Function to install Kubectl
install_kubectl() {
    echo "Installing Kubectl..."
    curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.18.9/2020-11-02/bin/linux/amd64/kubectl
    chmod +x ./kubectl
    sudo mv ./kubectl /usr/local/bin/kubectl
}

# Function to install Helm
install_helm() {
    echo "Installing Helm..."
    curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
}

# Check and install AWS CLI
if ! command -v aws &> /dev/null; then
    install_aws_cli
else
    echo "AWS CLI is already installed."
fi

# Check and install Terraform
if ! command -v terraform &> /dev/null; then
    install_terraform
else
    echo "Terraform is already installed."
fi

# Check and install Kubectl
if ! command -v kubectl &> /dev/null; then
    install_kubectl
else
    echo "Kubectl is already installed."
fi

# Check and install Helm
if ! command -v helm &> /dev/null; then
    install_helm
else
    echo "Helm is already installed."
fi
