# Kind example

Run Go42 locally on Kubernetes using Kind, Terraform, and Argo CD. For development and demos, not production.

Requires Docker running, Terraform 1.16.0, `kubectl`, and `make`.

Review [terraform.tfvars](terraform.tfvars) for cluster settings and the Go42 source SHA, image repository, and image digest. Keep the source and image pins on the same release.

From the repository root:

```sh
cd example/kind
make check   # Validate configuration and run mocked tests; no cluster created
make apply   # Create the cluster and deploy Go42
```

Default endpoints: HTTP `http://localhost:8080`, gRPC `localhost:50051`.
Kubeconfig is written to `.kubeconfig`.

To delete the cluster and its data:

```sh
make destroy
```
