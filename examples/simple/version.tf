terraform {
  required_version = "> 0.14.06"
  required_providers {
    tencentcloud = {
      source  = "tencentcloudstack/tencentcloud"
      version = ">= 1.79.14"
    }
  }
}
