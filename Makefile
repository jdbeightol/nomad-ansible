.terraform/providers/registry.terraform.io: provider.tf
	@terraform init

.terraform.plan: *.tf .terraform/providers/registry.terraform.io
	@terraform plan -out .terraform.plan

terraform.tfstate: .terraform.plan
	@terraform apply .terraform.plan

.inventory: terraform.tfstate
	@echo '[servers]' > .inventory
	@terraform output -json nomad_servers | jq --raw-output .[] >> .inventory
	@echo '[clients]' >> .inventory
	@terraform output -json nomad_clients | jq --raw-output .[] >> .inventory

build: .terraform.plan
.PHONY: build

deploy: terraform.tfstate
.PHONY: deploy

provision: export ANSIBLE_HOST_KEY_CHECKING := False
provision: .inventory
	@ansible-playbook -u root -i .inventory example-playbook.yml
.PHONY: provision

destroy:
	@terraform apply -destroy -auto-approve
.PHONY: destroy

clean:
	@rm -rf .terraform .terraform.plan .terraform.lock.hcl .inventory terraform.tfstate*
.PHONY: clean
