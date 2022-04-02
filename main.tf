terraform {
  required_version = "~> 1.0"
  required_providers {
    newrelic = {
      source  = "newrelic/newrelic"
    }
  }
}

# Configure the New Relic provider
provider "newrelic" {
  account_id = var.account_id
  api_key = var.user_api_key    # usually prefixed with 'NRAK'
  region = "US"                    # Valid regions are US and EU
}

module "k8s_alerts" {
	source = "./modules/newrelic_k8s_alerts"
    cluster_name = var.cluster_name
    account_id = var.account_id
	# alert_channel_ids = [data.newrelic_alert_channel.alert_channel.id]

	# service = {
	# 	name                       = "WebPortal"
	# 	duration                   = 5
	# 	cpu_threshold              = 90
	# 	response_time_threshold    = 5
	# 	error_percentage_threshold = 5
	# 	throughput_threshold       = 5
	# }
}