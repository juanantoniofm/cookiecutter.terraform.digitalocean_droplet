

.PHONY: help test pre-install
help: ## Show this help
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'


apply:  ## Apply the terraform and create all the resources (auto approve)
	@echo "Terraform apply"
	cd terraform; terraform fmt; terraform apply -auto-approve

.secrets/admin:
	@echo "Generating default secrets. Do not provide a password on the second key"
	# generate a set of default keys, you can change them anytime
	mkdir -p .secrets/
	ssh-keygen -f .secrets/admin
	ssh-keygen -f .secrets/deploy -P ""

terraform/.terraform: 
	# And prepare terraform
	@echo "Installing terraform with tfenv"
	tfenv install
	cd terraform; terraform init

install: .secrets/admin terraform/.terraform  ## Prepare your machine to run the code, and ask you for the key
#@echo "Enter your digital ocean API token now"

#Note:
# install and pre-install are really weird.
# The reason why install only holds the read, is to prevent it from 
# blocking the output of the whole script. When a target runs with $(shell),
# makes the whole command buffered, hiding the echo, hence seeming hanged or blocked.

fake-install: pre-install 
	# $(shell read dgtoken; echo ${dgtoken} >> .secrets/digital_ocean.token)
	#TODO: the key part of things is currently not working.
	

destroy:  ## Destroy the resources
	@echo "Destroying"
	cd terraform; terraform destroy -auto-approve

taint: ## Taint the instance to ensure it gets recreated
	cd terraform; terraform taint digitalocean_droplet.web

refresh: taint apply ## Recreate the droplet (only) - Use `make destroy apply` re-create everything

plan:  
	cd terraform; terraform fmt; terraform plan

ssh:  ## Login to the machine using root
	cd terraform; ssh -F ssh_config.tmp jatos-web

test:  ## validate that the machine is reachable
	$(shell cd terraform; pwd; ssh -F ssh_config.tmp  -o "StrictHostKeyChecking no" -o "VisualHostKey yes" jatos-web ls -lart | grep ".ssh"; echo $?)


