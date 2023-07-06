resource "openstack_compute_instance_v2" "test-server" {
  name            = "test-server"
  flavor_id       = var.compute.flavor_id
  key_pair        = var.compute.ssh_key
  security_groups = ["${openstack_compute_secgroup_v2.tf_secgroup.name}"]

  block_device {
    uuid                  = var.compute.image_id
    source_type           = "image"
    volume_size           = 30
    boot_index            = 0
    destination_type      = "volume"
    delete_on_termination = true
  }
  //image_id = var.compute.image_id

  network {
    name = openstack_networking_network_v2.tf_private.name
  }
}


# floating ip configuration
resource "openstack_networking_floatingip_v2" "test-server_ip" {
  pool = var.network.external_network_name
}

resource "openstack_compute_floatingip_associate_v2" "test-server_ip" {
  floating_ip = openstack_networking_floatingip_v2.test-server_ip.address
  instance_id = openstack_compute_instance_v2.test-server.id
}
