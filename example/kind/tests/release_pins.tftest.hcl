# All providers are mocked: these plan-only tests need no Docker daemon,
# kubeconfig, registry access, or existing cluster.
mock_provider "kind" {}
mock_provider "helm" {}
mock_provider "kubernetes" {}

run "uses_committed_release_pins" {
  command = plan

  assert {
    condition     = kubernetes_manifest.application.manifest.spec.source.targetRevision == var.go42_source_sha
    error_message = "Argo CD must use the selected release's full source commit SHA."
  }

  assert {
    condition     = yamldecode(kubernetes_manifest.application.manifest.spec.source.helm.values).image.digest == var.go42_image_digest
    error_message = "Argo CD must pass the selected release's image digest to Helm."
  }

  assert {
    condition     = !can(yamldecode(kubernetes_manifest.application.manifest.spec.source.helm.values).image.repository)
    error_message = "The image repository must come from the pinned chart, not the current organization name."
  }

  assert {
    condition     = kind_cluster.this.node_image == var.cluster_node_image
    error_message = "Kind must use the complete digest-pinned node image."
  }
}

run "rejects_floating_source_revision" {
  command = plan

  variables {
    go42_source_sha = "*"
  }

  expect_failures = [var.go42_source_sha]
}

run "rejects_empty_image_digest" {
  command = plan

  variables {
    go42_image_digest = ""
  }

  expect_failures = [var.go42_image_digest]
}

run "rejects_full_image_reference_as_digest" {
  command = plan

  variables {
    go42_image_digest = "ghcr.io/go42-dev/go42@sha256:013937c6bb0427d57f6df06627e831b696e78aa14e00f7720613b6c73c77b8ed"
  }

  expect_failures = [var.go42_image_digest]
}

run "rejects_unpinned_node_image" {
  command = plan

  variables {
    cluster_node_image = "kindest/node:v1.33.1"
  }

  expect_failures = [var.cluster_node_image]
}
