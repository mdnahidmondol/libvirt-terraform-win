terraform {
  source = "https://github.com/mdnahidmondol/libvirt-terraform-win?ref=78b2c57"
}

inputs = {
  create_vm         = true
  vm_count          = 1
  vm_name           = "windows10-kvm"
  vm_memory         = "4096"
  vm_vcpus          = 2
  disk_size         = 53687091200                   # 50 GB
  iso_path          = "/home/ubuntu/vm-test/Win10_21H2_English_x64.iso" # iso_path and storage_pool_path value must be provided
  storage_pool_path = "/home/ubuntu/data"
  network_name      = "windows10_network"
  network_mode      = "nat"
  network_address   = "192.168.122.0/24"
}