provider "tencentcloud" {
  region = "ap-guangzhou"
}

variable "availability_zones" {
  type    = list(string)
  default = ["ap-guangzhou"]
}


locals {
  create_instance = true
  create_namespace = true
  create_repository = true
  create_vpc_attachment = true
}

resource "tencentcloud_vpc" "main" {
  name       = "test-vpc"
  cidr_block = "10.0.0.0/16"
  tags = {
    "createBy" = "terraform"
  }
}

resource "tencentcloud_subnet" "subnet" {
  availability_zone = var.availability_zones[0]
  name              = "test-subnet"
  vpc_id            = tencentcloud_vpc.main.id
  cidr_block        = "10.0.20.0/28"
  is_multicast      = false
  tags = {
    "createBy" = "terraform"
  }
}
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





module "security_group" {
  source = "terraform-tencentcloud-modules/security-group/tencentcloud"

  name        = "clb-security-group"
  description = "clb-security-group-test"

  ingress_with_cidr_blocks = [
    {
      cidr_block = "10.0.0.0/16"
    },
    {
      port       = "80"
      cidr_block = "10.1.0.0/16"
    },
    {
      port       = "808"
      cidr_block = "10.2.0.0/16"
      policy     = "drop"
    },
    {
      port       = "8088"
      protocol   = "UDP"
      cidr_block = "10.3.0.0/16"
      policy     = "accept"
    },
    {
      port        = "8080-9090"
      protocol    = "TCP"
      cidr_block  = "10.4.0.0/16"
      policy      = "accept"
      description = "simple-security-group"
    },
  ]

  egress_with_cidr_blocks = [
    {
      cidr_block = "10.0.0.0/16"
    },
    {
      port       = "80"
      cidr_block = "10.1.0.0/16"
    },
    {
      port       = "808"
      cidr_block = "10.2.0.0/16"
      policy     = "drop"
    },
    {
      port       = "8088"
      protocol   = "UDP"
      cidr_block = "10.3.0.0/16"
      policy     = "accept"
    },
    {
      port        = "8080-9090"
      protocol    = "TCP"
      cidr_block  = "10.4.0.0/16"
      policy      = "accept"
      description = "simple-security-group"
    },
  ]

  tags = {
    module = "security-group"
  }

  security_group_tags = {
    test = "security-group"
  }
}
