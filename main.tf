# Configure the New Relic provider
terraform {
  required_version = "~> 1.0"
  required_providers {
    newrelic = {
      source = "newrelic/newrelic"
    }
  }
}

provider "newrelic" {
  account_id = var.account_id
  api_key    = var.user_api_key # usually prefixed with 'NRAK'
  region     = "US"             # Valid regions are US and EU
}

module "newrelic_k8s_alerts" {
  source                 = "./modules/newrelic_k8s_alerts"
  cluster_name           = var.cluster_name
  account_id             = var.account_id
  enable_pods_containers = true
  enable_nodes           = true
  enable_control_plane   = false
}