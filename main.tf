provider "libvirt" {
  uri = "qemu:///system"
}


resource "libvirt_pool" "kvm_storage" {
  name = "windows10_pool"
  type = "dir"
  path = var.storage_pool_path
}


resource "libvirt_volume" "windows10_disk" {
  count  = var.create_vm ? var.vm_count : 0
  name   = "${var.vm_name}-${count.index + 1}.qcow2"
  pool   = libvirt_pool.kvm_storage.name
  size   = var.disk_size
  format = "qcow2"
}

# network for the VM with port forwarding for RDP
resource "libvirt_network" "kvm_network" {
  name      = var.network_name
  mode      = var.network_mode
  addresses = [var.network_address]

  dhcp {
    enabled = true
  }

  dns {
    enabled = true
  }

  autostart = true

  # Forward RDP port (3389) from the host to the guest
 xml {
    xslt = <<EOF
    <?xml version="1.0" ?>
    <xsl:stylesheet version="1.0"
                    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
      <xsl:output omit-xml-declaration="yes" indent="yes"/>
      <xsl:template match="node()|@*">
        <xsl:copy>
          <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
      </xsl:template>
      <xsl:template match="/network">
        <xsl:copy>
          <xsl:apply-templates select="node()|@*"/>
          <forward mode='nat'>
            <nat>
              <port start='3389' end='3389'/>
            </nat>
          </forward>
        </xsl:copy>
      </xsl:template>
    </xsl:stylesheet>
    EOF
  }
}


resource "libvirt_domain" "windows10_vm" {
  count  = var.create_vm ? var.vm_count : 0
  name   = "${var.vm_name}-${count.index + 1}"
  memory = var.vm_memory
  vcpu   = var.vm_vcpus

  disk {
    volume_id = libvirt_volume.windows10_disk[count.index].id

  }

  disk {
    file    = var.iso_path
    scsi    = "true"  # Optionally use SCSI for the CDROM
  }


  network_interface {
    network_id     = libvirt_network.kvm_network.id
    wait_for_lease = true
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  boot_device {
    dev = ["cdrom", "hd"]
  }
}
