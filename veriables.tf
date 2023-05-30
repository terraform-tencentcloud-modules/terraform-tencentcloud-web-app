variable "create" {
  description = "Determines whether resources will be created (affects all resources)"
  type = bool
  default = true
}

variable "create_instance" {
  description = "Whether to create the tencentcloud_tcr_instance"
  type = bool
  default = true
}

variable "create_namespace" {
  description = "Whether to create the tencentcloud_tcr_namespace"
  type = bool
  default = false
}

variable "create_repository" {
  description = "Whether to create the tencentcloud_tcr_repository"
  type = bool
  default = false
}

variable "create_vpc_attachment" {
  description = "Whether to create the tencentcloud_tcr_vpc_attachment"
  type = bool
  default = false
}

variable "create_token" {
  description = "Whether to create the tencentcloud_tcr_token"
  type = bool
  default = false
}

variable "instance_id" {
  description = "The TCR instance ID"
  type        = string
  default     = ""
}

##################################################
# Instance
##################################################

variable "instance_type" {
  description = "The TCR instance type"
  type        = string
  default     = "basic"
}

variable "instance_name" {
  description = "The TCR instance name"
  type        = string
  default     = "tcr-default"
}

variable "delete_bucket" {
  description = "Whether to delete the COS bucket which is auto-created with instance"
  type = bool
  default = false
}

variable "open_public_operation" {
  description = "Whether this TCR instance is public accessible"
  type        = bool
  default     = false
}

variable "replications" {
  description = "Specify List of instance Replications, premium for instance_type only"
  type = list(map(any))
  default = []
}

variable "security_policies" {
  description = "The list of security policies"
  type        = list(map(string))
  default     = []
}

variable "tags" {
  description = "The tags applied to this TCR instance"
  type        = map(string)
  default     = {}
}

##################################################
# Namespace
##################################################

variable "namespace_name" {
  description = "Name of namespaces to be created"
  type        = string
  default     = "default_namespace"
}

variable "is_public" {
  description = "Indicate that the namespace is public or not"
  type        = bool
  default     = false
}

##################################################
# Repository
##################################################

variable "repository_name" {
  description = "Name of repository to be created"
  type        = string
  default     = "default_repository"
}

variable "repo_brief_desc" {
  description = "Brief description of the repository"
  type        = string
  default     = ""
}

variable "repo_desc" {
  description = "Description of the repository"
  type        = string
  default     = ""
}

##################################################
# Token
##################################################

variable "token_desc" {
  description = "Description of the token"
  type        = string
  default = ""
}

variable "enable" {
  description = "Indicate to enable this token or not"
  type        = bool
  default = false
}

##################################################
# Vpc attachment
##################################################

variable "vpc_id" {
  description = "The VPC ID for the VPC attachment"
  type        = string
  default = ""
}

variable "subnet_id" {
  description = "The Subnet ID for the VPC attachment."
  type        = string
  default = ""
}

variable "enable_public_domain_dns" {
  description = "Whether to enable public domain dns"
  type        = bool
  default = false
}

variable "enable_vpc_domain_dns" {
  description = "Whether to enable vpc domain dns"
  type        = bool
  default = false
}

variable "region_name" {
  description = "Name of region"
  type        = string
  default     = ""
}

##################################################
#                 CLB
##################################################

variable "project_id" {
  description = "Id of the project within the CLB instance, '0' - Default Project."
  type        = number
  default     = null
}

# clb variables
variable "clb_name" {
  description = "Name of the CLB. The name can only contain Chinese characters, English letters, numbers, underscore and hyphen '-'."
  type        = string
  default     = "tf-modules-clb"
}

variable "clb_tags" {
  description = "The available tags within this CLB."
  type        = map(string)
  default     = {}
}

variable "network_type" {
  description = "Type of CLB instance, and available values include 'OPEN' and 'INTERNAL'."
  type        = string
  default     = ""
}


variable "security_groups" {
  description = "Security groups of the CLB instance. Only supports 'OPEN' CLBs."
  type        = list(string)
  default     = null
}

variable "create_clb_log" {
  description = "Whether to create clb log"
  type        = bool
  default     = false
}

variable "clb_log_set_period" {
  type        = number
  default     = 7
  description = "Logset retention period in days. Maximun value is 90."
}

variable "clb_log_topic_name" {
  type        = string
  default     = "clb_topic"
  description = "Log topic of CLB instance."
}

variable "log_set_id" {
  type        = string
  default     = ""
  description = "The id of log set."
}

variable "log_topic_id" {
  type        = string
  default     = ""
  description = "The id of log topic."
}

variable "address_ip_version" {
  description = "IP version, only applicable to open CLB. Valid values are ipv4, ipv6 and IPv6FullChain."
  type        = string
  default     = null
}

variable "bandwidth_package_id" {
  description = "Bandwidth package id. If set, the internet_charge_type must be BANDWIDTH_PACKAGE."
  type        = string
  default     = null
}

variable "internet_bandwidth_max_out" {
  description = "Max bandwidth out, only applicable to open CLB. Valid value ranges is [1, 2048]. Unit is MB."
  type        = number
  default     = null
}

variable "internet_charge_type" {
  description = "Internet charge type, only applicable to open CLB. Valid values are TRAFFIC_POSTPAID_BY_HOUR, BANDWIDTH_POSTPAID_BY_HOUR and BANDWIDTH_PACKAGE."
  type        = string
  default     = null
}

variable "load_balancer_pass_to_target" {
  description = "Whether the target allow flow come from clb. If value is true, only check security group of clb, or check both clb and backend instance security group."
  type        = bool
  default     = null
}

variable "master_zone_id" {
  description = "Setting master zone id of cross available zone disaster recovery, only applicable to open CLB."
  type        = string
  default     = null
}

variable "slave_zone_id" {
  description = "Setting slave zone id of cross available zone disaster recovery, only applicable to open CLB. this zone will undertake traffic when the master is down."
  type        = string
  default     = null
}

variable "snat_ips" {
  description = "Snat Ip List, required with snat_pro=true. NOTE: This argument cannot be read and modified here because dynamic ip is untraceable, please import resource tencentcloud_clb_snat_ip to handle fixed ips."
  type        = list(map(string))
  default     = []
}

variable "snat_pro" {
  description = "Indicates whether Binding IPs of other VPCs feature switch."
  type        = bool
  default     = null
}


variable "target_region_info_region" {
  description = "Region information of backend services are attached the CLB instance. Only supports OPEN CLBs."
  type        = string
  default     = null
}

variable "target_region_info_vpc_id" {
  description = "Vpc information of backend services are attached the CLB instance. Only supports OPEN CLBs."
  type        = string
  default     = null
}

variable "zone_id" {
  description = "Available zone id, only applicable to open CLB."
  type        = string
  default     = null
}

variable "create_listener" {
  type        = bool
  default     = true
  description = "Whether to create a CLB Listener."
}

variable "clb_listeners" {
  description = "The CLB Listener config list."
  type        = list(map(string))
  default     = []
}

variable "create_listener_rules" {
  type        = bool
  default     = false
  description = "Whether to create a CLB Listener rules."
}

variable "clb_listener_rules" {
  description = "The CLB listener rule config list."
  type        = list(map(string))
  default     = []
}

variable "create_clb_redirections" {
  type        = bool
  default     = false
  description = "Whether to create a CLB Listener rules redirection."
}

variable "clb_redirections" {
  description = "The CLB redirection config list."
  type        = list(map(string))
  default     = []
}