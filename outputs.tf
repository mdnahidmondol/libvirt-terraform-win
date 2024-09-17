# Output the IP addresses of the VMs
output "vm_ip_addresses" {
  description = "The IP addresses of the Windows 10 VMs"
  value       = libvirt_domain.windows10_vm[*].network_interface[0].addresses[0]
}