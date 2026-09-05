variable "cluster_name" {
  description = "The name of the Kind cluster."
  type        = string
  default     = "go42"
}

variable "cluster_node_image" {
  description = "Kind node image, including its Kubernetes version tag and immutable multi-platform manifest digest."
  type        = string
  nullable    = false
  validation {
    condition     = can(regex("^kindest/node:v[0-9]+\\.[0-9]+\\.[0-9]+@sha256:[0-9a-f]{64}$", var.cluster_node_image))
    error_message = "cluster_node_image must be kindest/node:vX.Y.Z@sha256:<64 lowercase hexadecimal characters>."
  }
}

variable "go42_source_sha" {
  description = "Full Git commit SHA containing the Helm chart from the selected Go42 release. Update together with go42_image_digest."
  type        = string
  nullable    = false
  validation {
    condition     = can(regex("^[0-9a-f]{40}$", var.go42_source_sha))
    error_message = "go42_source_sha must be a full 40-character lowercase Git commit SHA, not a branch, tag, or version range."
  }
}

variable "go42_image_digest" {
  description = "Immutable multi-platform container image digest from the same release as go42_source_sha."
  type        = string
  nullable    = false
  validation {
    condition     = can(regex("^sha256:[0-9a-f]{64}$", var.go42_image_digest))
    error_message = "go42_image_digest must be sha256:<64 lowercase hexadecimal characters>, without a repository prefix."
  }
}

variable "control_plane_nodes" {
  description = "Number of control-plane nodes in the Kind cluster."
  type        = number
  default     = 1
  validation {
    condition     = var.control_plane_nodes >= 1
    error_message = "The number of control-plane nodes must be at least one."
  }
}

variable "worker_nodes" {
  description = "Number of worker nodes in the Kind cluster."
  type        = number
  default     = 2
  validation {
    condition     = var.worker_nodes >= 0
    error_message = "The number of worker nodes must be zero or positive."
  }
}

variable "kubeconfig_output_path" {
  description = "Path to write the generated .kubeconfig."
  type        = string
  default     = ".kubeconfig"
}

variable "extra_port_mappings" {
  description = "A list of extra port mappings from the host to the control-plane node(s). Each mapping is an object with container_port and host_port."
  type = list(object({
    container_port = number
    host_port      = number
  }))
  default = []
}
