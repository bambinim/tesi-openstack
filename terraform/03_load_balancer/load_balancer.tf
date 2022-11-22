# load balancer
resource "openstack_lb_loadbalancer_v2" "web_lb" {
  name          = "web_lb"
  vip_subnet_id = openstack_networking_subnet_v2.web_private_subnet.id
}

# targets pool
resource "openstack_lb_pool_v2" "web_lb_pool" {
  name            = "web_lb_pool"
  protocol        = "HTTP"
  lb_method       = "ROUND_ROBIN"
  loadbalancer_id = openstack_lb_loadbalancer_v2.web_lb.id
}

# pool members
resource "openstack_lb_members_v2" "web_lb_pool_members" {
  pool_id = openstack_lb_pool_v2.web_lb_pool.id

  # iterate all instances and add their IP address to the pool
  dynamic "member" {
    for_each = openstack_compute_instance_v2.web-server
    iterator = instance
    content {
      address       = instance.value.network[0].fixed_ip_v4
      protocol_port = 80
      weight        = 1
    }
  }
}

# HTTP listener
resource "openstack_lb_listener_v2" "web_lb_listener" {
  name            = "web_lb_listener_http"
  protocol        = "HTTP"
  protocol_port   = 80
  loadbalancer_id = openstack_lb_loadbalancer_v2.web_lb.id
  default_pool_id = openstack_lb_pool_v2.web_lb_pool.id
}

# floating IP
resource "openstack_networking_floatingip_v2" "web_lb_floating_ip" {
  pool = var.network.external_network_name
}

resource "openstack_networking_floatingip_associate_v2" "web_lb_floating_ip_associate" {
  floating_ip = openstack_networking_floatingip_v2.web_lb_floating_ip.address
  port_id     = openstack_lb_loadbalancer_v2.web_lb.vip_port_id
}