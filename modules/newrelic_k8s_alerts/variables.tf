variable "account_id" {
    description = "New Relic Account ID"
    type = string
}

variable "cluster_name" {
	description = "The cluster to create alerts for"
	type = string
}

variable "enable_pods_containers" {
  type        = bool
  description = <<EOT
    Enable pod and container alerts.

    Default: true
  EOT
  default     = true
}

variable "enable_nodes" {
  type        = bool
  description = <<EOT
    Enable node alerts.

    Default: true
  EOT
  default     = true
}