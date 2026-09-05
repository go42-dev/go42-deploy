## Go42 v0.9.77: https://github.com/go42-dev/go42/releases/tag/v0.9.77
# The pinned chart uses ghcr.io/hasansino/go42; this release predates the org move.
# Update the source SHA and image digest together from one verified release.
go42_source_sha   = "9aef95d360c042f210a8c71b06152f5137ecd2c2"
go42_image_digest = "sha256:013937c6bb0427d57f6df06627e831b696e78aa14e00f7720613b6c73c77b8ed"

cluster_name           = "go42"
cluster_node_image     = "kindest/node:v1.33.1@sha256:050072256b9a903bd914c0b2866828150cb229cea0efe5892e2b644d5dd3b34f"
control_plane_nodes    = 1
worker_nodes           = 2
kubeconfig_output_path = ".kubeconfig"
extra_port_mappings = [
  { host_port = 8080, container_port = 80 },
  { host_port = 50051, container_port = 50051 }
]
