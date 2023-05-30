output "instance_id" {
  description = "The TCR instance ID."
  value       = module.tencentcloud_tcr_instance.*.instance_id
}
