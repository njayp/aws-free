# Path to the private key file
PRIVATE_KEY = private_key.pem

# Terraform output to get the instance public IP
INSTANCE_IP = $(shell terraform output -raw ec2_ip)

# SSH target
ssh:
	@if [ -z "$(INSTANCE_IP)" ]; then \
		echo "Error: Instance IP not found. Ensure Terraform is applied."; \
		exit 1; \
	fi
	ssh -i $(PRIVATE_KEY) ec2-user@$(INSTANCE_IP)
