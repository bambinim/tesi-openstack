resource "openstack_networking_network_v2" "tf_private" {
  name           = "tf_private"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "tf_subnet" {
  name            = "tf_subnet"
  network_id      = openstack_networking_network_v2.tf_private.id
  ip_version      = 4
  cidr            = "192.168.1.0/24"
  gateway_ip      = "192.168.1.1"
  dns_nameservers = var.network.dns_nameservers
}

resource "openstack_compute_secgroup_v2" "tf_secgroup" {
  name        = "tf_secgroup"
  description = "Terraform security group"

  rule {
    from_port   = 22
    to_port     = 22
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }
}

resource "openstack_networking_router_v2" "tf_router" {
  name                = "tf_router"
  admin_state_up      = true
  external_network_id = var.network.external_network_id
}

resource "openstack_networking_router_interface_v2" "tf_router_interface" {
  router_id = openstack_networking_router_v2.tf_router.id
  subnet_id = openstack_networking_subnet_v2.tf_subnet.id
}