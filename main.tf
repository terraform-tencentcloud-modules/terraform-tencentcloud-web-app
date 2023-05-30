locals {
# TCR
  instance_id = var.instance_id != "" ? var.instance_id : concat(module.tencentcloud_tcr_instance.*.instance_id, [""])[0]
  namespace_name = var.namespace_name != "" ? var.namespace_name : concat(module.tencentcloud_tcr_instance.*.namespace_name, [""])[0]
  repository_name = var.repository_name != "" ? var.repository_name : concat(module.tencentcloud_tcr_instance.*.repository_name, [""])[0]
  create_instance = var.create_instance
  create_namespace = var.create_namespace
  create_repository = var.create_repository
  create_vpc_attachment = var.create_vpc_attachment
  create_token = var.create_token

}


module "tencentcloud_tcr_instance" {
  source = "terraform-tencentcloud-modules/tcr/tencentcloud"
  instance_name         = var.instance_name
  instance_type         = var.instance_type
  delete_bucket         = var.delete_bucket
  open_public_operation = var.open_public_operation
  replications = var.replications
  security_policies = var.security_policies
  tags = var.tags

  # TCR namespace
  create_namespace = local.create_namespace
  instance_id      = var.instance_id
  namespace_name        = var.namespace_name
  is_public             = var.is_public

  # TCR repository
  create_repository     = local.create_repository
  repository_name       = var.repository_name
  repo_brief_desc       = var.repo_brief_desc
  repo_desc             = var.repo_desc

  # TCR VPC attachment
  create_vpc_attachment = local.create_vpc_attachment
  vpc_id                = var.vpc_id
  subnet_id             = var.subnet_id


  create_token = local.create_token
  token_desc = var.token_desc
}

module "tencentcloud_clb_instance" {
  source = "terraform-tencentcloud-modules/clb/tencentcloud"
  project_id      = var.project_id
  clb_name        = var.clb_name
  tags            = var.clb_tags
  network_type    = var.network_type
  vpc_id          = var.vpc_id == null ? 0 : var.vpc_id
  subnet_id       = var.vpc_id != null ? var.subnet_id : null
  security_groups = var.security_groups

  address_ip_version           = var.address_ip_version
  bandwidth_package_id         = var.bandwidth_package_id
  internet_bandwidth_max_out   = var.internet_bandwidth_max_out
  internet_charge_type         = var.internet_charge_type
  load_balancer_pass_to_target = var.load_balancer_pass_to_target
  master_zone_id               = var.master_zone_id
  slave_zone_id                = var.slave_zone_id
  snat_ips = var.snat_ips
  snat_pro                  = var.snat_pro
  target_region_info_region = var.target_region_info_region
  target_region_info_vpc_id = var.target_region_info_vpc_id
  zone_id                   = var.zone_id



  clb_log_set_period = var.clb_log_set_period
  clb_log_topic_name = var.clb_log_topic_name
  
  create_listener  = var.create_listener

  clb_listeners              = var.clb_listeners

  create_listener_rules      = length(var.clb_listener_rules) > 0 ? true : false
  clb_listener_rules         = var.clb_listener_rules
  
  clb_redirections        = var.clb_redirections
}


