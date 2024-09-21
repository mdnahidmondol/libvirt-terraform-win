
variable "create_vm" {
  description = "Whether to create the VM or not"
  type        = bool
  default     = true
}

variable "vm_count" {
  description = "Number of VMs to create"
  type        = number
  default     = 1
}

variable "vm_name" {
  description = "Name of the Windows 10 VM. example: windows10-kvm"
  default     = "windows10-kvm"
}

variable "vm_memory" {
  description = "Memory allocated to the VM in MB. example: 4096. calculated as 4 * 1024"
  default     = "4096"
}

variable "vm_vcpus" {
  description = "Number of virtual CPUs for the VM"
  default     = 2
}

variable "disk_size" {
  description = "Size of the VM's disk in bytes. example: 53687091200 (50 GB), calculated as 50 * 1024 * 1024 * 1024"
  default     = 53687091200 # 50 GB
}

variable "iso_path" {
  description = "Path to the Windows ISO file path. example: /path/to/your/windows10.iso"
  type        = string
}

variable "storage_pool_path" {
  description = "Path for the libvirt storage pool. example: /var/lib/libvirt/images" 
  type        = string
}

variable "network_name" {
  description = "Name of the network for the VM"
  default     = "windows10_network"
}

variable "network_mode" {
  description = "Network mode (usually 'nat') options: nat, bridge, isolated"
  default     = "nat"
}

variable "network_address" {
  description = "Network address range"
  default     = "192.168.122.0/24"
}


