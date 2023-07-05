resource "openstack_compute_instance_v2" "web-server" {
  name            = "web-server-${count.index}"
  flavor_id       = var.compute.flavor_id
  image_id        = var.compute.image_id
  key_pair        = var.compute.ssh_key
  security_groups = ["${openstack_compute_secgroup_v2.web_secgroup.name}"]
  count           = var.compute.instance_count
  #user_data = replace("${file("init-instance.sh")}", "#x", count.index)
  #user_data = "${file("init-instance.sh")}"
  user_data = templatefile("${path.module}/init-instance.sh", {
    instance_idx = count.index
  })

  network {
    name = openstack_networking_network_v2.web_private.name
  }

}
