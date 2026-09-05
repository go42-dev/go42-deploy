.PHONY: help check apply destroy
help: Makefile
	@sed -n 's/^##//p' $< | awk 'BEGIN {FS = "|"}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

## check | validate configuration and run mocked tests without creating infrastructure
check:
	@terraform init -backend=false -input=false -lockfile=readonly && \
	terraform fmt -check -recursive && \
	terraform validate && \
	terraform test

## apply | create terraform resources
# Dependencies:
#   * brew install terraform
#   * brew install kubectl
apply:
	@terraform init -lockfile=readonly && \
	terraform apply -auto-approve -target=kind_cluster.this && \
	terraform apply -auto-approve -target=helm_release.ingress_nginx_http && \
	terraform apply -auto-approve -target=helm_release.ingress_nginx_grpc && \
	terraform apply -auto-approve -target=helm_release.argocd && \
	terraform apply -auto-approve -target=kubernetes_manifest.application

## destroy | destroy terraform resources
# Dependencies:
#   * brew install terraform
destroy:
	@terraform destroy -auto-approve
