variable "account_id" {
    description = "New Relic Account ID"
    type = string
}

variable "cluster_name" {
	description = "The cluster to create alerts for"
	type = string
}

variable "user_api_key" {
	description = "New Relic User API Key"
	type = string
}