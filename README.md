# TencentCloud TCR for Terraform

## terraform-tencentcloud-tcr

A terraform module used for create TencentCloud Container Registry

These types of resources are supported:

* [tencentcloud_tcr_instance](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/tcr_instance)
* [tencentcloud_tcr_namespace](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/tcr_namespace)
* [tencentcloud_tcr_repository](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/tcr_repository)
* [tencentcloud_tcr_token](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/tcr_token)
* [tencentcloud_tcr_vpc_attachment](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/tcr_vpc_attachment)
* [CLB](https://www.terraform.io/docs/providers/tencentcloud/r/clb_instance.html)
* [CLB Listener](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/clb_listener)
* [CLB Listener Rule](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/clb_listener_rule)
* [CLB_Redirection](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/clb_redirection)
* [CLB Log Set](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/clb_log_set)
* [CLB Log Topic](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/clb_log_topic)

## Usage

### Private Repository
```hcl
module "tcr-with-clb" {
  source = "../../"

  # TCR instance
  create_instance = local.create_instance
  instance_name         = "tcr_instance"
  instance_type         = "basic"
  open_public_operation = false
  security_policies     = [
    {
      cidr_block  = "98.153.142.170/32"
      description = "JLiao laptop"
    },
    {
      cidr_block  = "10.0.0.0/16"
      description = "VPC private network access"
    }
  ]
  tags                  = {
    test = "tf"
  }

  # TCR namespace
  create_namespace = local.create_namespace
  instance_id      = ""
  namespace_name                  = "tcr_namespace"
  is_public                  = true

  # TCR repository
  create_repository = local.create_repository
  repository_name = "test-repository-name"
  repo_brief_desc = "test brief description"
  repo_desc = "test repository description"

  # TCR VPC attachment
  create_vpc_attachment = local.create_vpc_attachment
  vpc_id    = tencentcloud_vpc.main.id
  subnet_id = tencentcloud_subnet.subnet.id

  # CLB

  network_type       = "OPEN"
  clb_name           = "tf-clb-module-with-log"
  project_id         = 0
  security_groups    = [module.security_group.security_group_id]
  create_clb_log     = true
  clb_log_set_period = 7
  clb_log_topic_name = "clb_topic"

  clb_listeners = [
    {
      listener_name       = "tcp_listener"
      protocol            = "TCP"
      port                = 66
      session_expire_time = 30
    }
  ]

  clb_tags = {
    test = "tf-clb-module"
  }
}
```



## Examples

* [complete example]()


## Terraform versions

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_tencentcloud"></a> [tencentcloud](#provider\_tencentcloud) | >= 1.59.4 |

## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
|create|Determines whether resources will be created (affects all resources)|bool|true|no|
|create_instance|Whether to create the tencentcloud_tcr_instance|bool|false|no|
|create_namespace|Whether to create the tencentcloud_tcr_namespace|bool|false|no|
|create_repository|Whether to create the tencentcloud_tcr_repository|bool|false|no|
|create_vpc_attachment|Whether to create the tencentcloud_tcr_vpc_attachment|bool|false|no|
|create_token|Whether to create the tencentcloud_tcr_token|bool|false|no|
|instance_id|The TCR instance ID|string|`""`|no|
|instance_type|The TCR instance type|string|`basic`|no|
|instance_name|The TCR instance name|string|`null`|no|
|delete_bucket|Whether to delete the COS bucket which is auto-created with instance|bool|false|no|
|open_public_operation|Whether this TCR instance is public accessible|bool|false|no|
|replications|Specify List of instance Replications, premium for instance_type only|list(map(any))|`[]`|no|
|security_policies|The list of security policies|list(map(string))|`[]`|no|
|tags|The tags applied to this TCR instance|map(string)|`{}`|no|
|namespace_name|Name of namespaces to be created|string|`null`|no|
|is_public|Indicate that the namespace is public or not|bool|false|no|
|repository_name|Name of repository to be created|string|`null`|no|
|repo_brief_desc|Brief description of the repository|string|`null`|no|
|repo_desc|Description of the repository|string|`null`|no|
|token_desc|Description of the token|string|`""`|no|
|enable|Indicate to enable this token or not|bool|false|no|
|vpc_id|The VPC ID for the VPC attachment|string|`""`|no|
|subnet_id|The Subnet ID for the VPC attachment|string|`""`|no|
|enable_public_domain_dns|Whether to enable public domain dns|bool|false|no|
|enable_vpc_domain_dns|Whether to enable vpc domain dns|bool|false|no|
|region_name|Name of region|string|`""`|no|
| project_id                   | Id of the project within the CLB instance, '0' - Default Project. |    number    |      null      |    no    |
| clb_name                     | Name of the CLB. The name can only contain Chinese characters, English letters, numbers, underscore and hyphen '-'. |    string    | tf-modules-clb |    no    |
| clb_tags                     | The available tags within this CLB.                          | map(string)  |       {}       |    no    |
| network_type                 | Type of CLB instance, and available values include 'OPEN' and 'INTERNAL'. |    string    |      null      |    no    |
| vpc_id                       | VPC id of the CLB.                                           |    string    |      null      |    no    |
| subnet_id                    | Subnet id of the CLB. Effective only for CLB within the VPC. Only supports 'INTERNAL' CLBs. |    string    |      null      |    no    |
| security_groups              | Security groups of the CLB instance. Only supports 'OPEN' CLBs. | list(string) |      null      |    no    |
| create_clb_log               | Whether to create clb log.  Priority is lower than log_set_id and log_topic_id. |     bool     |      false      |   no    |
| clb_log_set_period           | Logset retention period in days. Maximun value is 90.        |    number    |       7        |    no    |
| clb_log_topic_name           | Log topic of CLB instance.                       |    string    |  "clb-topic"   |    no    |
| log_set_id                   | The id of log set.                               |    string    |  "" | no
| log_topic_id                 | The id of log topic.                             |    string    |  "" | no   |
| address_ip_version           | IP version, only applicable to open CLB. Valid values are ipv4, ipv6 and IPv6FullChain. |  string |  null  | no |
| bandwidth_package_id         | Bandwidth package id. If set, the internet_charge_type must be BANDWIDTH_PACKAGE. |  string  |  null |  no  |
| internet_bandwidth_max_out   | Max bandwidth out, only applicable to open CLB. Valid value ranges is [1, 2048]. Unit is MB. |  number  |  null  |  no  |
| internet_charge_type         | Internet charge type, only applicable to open CLB. Valid values are TRAFFIC_POSTPAID_BY_HOUR, BANDWIDTH_POSTPAID_BY_HOUR and BANDWIDTH_PACKAGE. |  string  |  null  |  no  |
| load_balancer_pass_to_target | Whether the target allow flow come from clb. If value is true, only check security group of clb, or check both clb and backend instance security group. |     bool     |      null      |   Yes    |
| master_zone_id               | Setting master zone id of cross available zone disaster recovery, only applicable to open CLB. |  string  |  null  |  no  |
| slave_zone_id                | Setting slave zone id of cross available zone disaster recovery, only applicable to open CLB. this zone will undertake traffic when the master is down. |  string  |  null  |  no  |
| snat_ips                     | Snat Ip List, required with snat_pro=true. NOTE: This argument cannot be read and modified here because dynamic ip is untraceable, please import resource tencentcloud_clb_snat_ip to handle fixed ips. |  list(map(string))  |  []  |  no  |
| snat_pro                     | Indicates whether Binding IPs of other VPCs feature switch.  |  bool  |  null  |  no  |
| tags                         | The available tags within this CLB.  |  map(any)  |  null  |  no  |
| target_region_info_region    | Region information of backend services are attached the CLB instance. Only supports OPEN CLBs. |    string    |       ""       |    no    |
| target_region_info_vpc_id    | Vpc information of backend services are attached the CLB instance. Only supports OPEN CLBs.  |  string  |  null  |  no  |
| zone_id                      | Available zone id, only applicable to open CLB.  |  string  |  null  |  no  |
| create_listener              | Whether to create a CLB Listeners. | bool |  true  |  no  |
| clb_listeners                | The CLB Listener config list. Valid values reference [clb_listener](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/clb_listener#argument-reference). | list(map(string)) |       []       |    no    |
| create_listener_rules        | Whether to create a CLB Listener rules. |  bool  |   false   |  no  |
| clb_listener_rules           | The CLB listener rule config list. The index of the clb_listeners parameter is matched by the listener_index. For other valid values reference [clb_listener_rule](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/clb_listener_rule#argument-reference) |  list(map(string))  |  []  |  no  |
| create_clb_redirections      | Whether to create a CLB Listener rules redirection.  |  bool  |  false  |  no  |
| clb_redirections             | The CLB redirection config list. Use source_listener_rule_index/target_listener_rule_index to get source_listener_id/target_listener_id in clb_listener_rules，For other valid values reference [clb_redirection](https://registry.terraform.io/providers/tencentcloudstack/tencentcloud/latest/docs/resources/clb_redirection#argument-reference) |  list(map(string))  |  []  |  no  |

## outputs

| Name | Description |
|------|-------------|
|instance_id|The TCR instance ID|

## License

Mozilla Public License Version 2.0.
See LICENSE for full details.
