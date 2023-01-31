resource "tencentcloud_vpc" "vpc" {
  name       = var.vpc_name
  cidr_block = var.network_cidr

  tags = var.tags
}

resource "tencentcloud_subnet" "sub" {
  vpc_id            = tencentcloud_vpc.vpc.id
  name              = var.subnet_name
  cidr_block        = var.network_cidr
  availability_zone = var.availability_zone

  tags = var.tags
}

resource "tencentcloud_eip" "eip" {
  name = var.eip_name
}

resource "tencentcloud_nat_gateway" "nat" {
  name             = "tke_nat"
  vpc_id           = tencentcloud_vpc.vpc.id
  bandwidth        = 100
  max_concurrent   = 1000000
  assigned_eip_set = [tencentcloud_eip.eip.public_ip]

  tags = var.tags
}

resource "tencentcloud_route_table" "rt" {
  vpc_id = tencentcloud_vpc.vpc.id
  name   = var.route_table_name

  tags = var.tags
}

resource "tencentcloud_route_table_entry" "instance" {
  route_table_id         = tencentcloud_route_table.rt.id
  destination_cidr_block = "0.0.0.0/0"
  next_type              = "NAT"
  next_hub               = tencentcloud_nat_gateway.nat.id
  description            = "nat entry"
}

resource "tencentcloud_security_group" "sg" {
  name        = var.security_group_name
  project_id  = 0
}

resource "tencentcloud_security_group_rule" "sg_ingress_rule1" {
  security_group_id = tencentcloud_security_group.sg.id
  type              = "ingress"
  cidr_ip           = "0.0.0.0/0"
  ip_protocol       = "TCP"
  port_range        = "22"
  policy            = "ACCEPT"
  description       = "all accept"
}

resource "tencentcloud_security_group_rule" "sg_ingress_rule2" {
  security_group_id = tencentcloud_security_group.sg.id
  type              = "ingress"
  cidr_ip           = "0.0.0.0/0"
  ip_protocol       = "TCP"
  port_range        = "3389"
  policy            = "ACCEPT"
  description       = "all accept"
}

resource "tencentcloud_security_group_rule" "sg_ingress_rule3" {
  security_group_id = tencentcloud_security_group.sg.id
  type              = "ingress"
  cidr_ip           = "0.0.0.0/0"
  ip_protocol       = "TCP"
  port_range        = "80"
  policy            = "ACCEPT"
  description       = "all accept"
}

resource "tencentcloud_security_group_rule" "sg_ingress_rule4" {
  security_group_id = tencentcloud_security_group.sg.id
  type              = "ingress"
  cidr_ip           = "0.0.0.0/0"
  ip_protocol       = "TCP"
  port_range        = "443"
  policy            = "ACCEPT"
  description       = "all accept"
}

resource "tencentcloud_security_group_rule" "sg_ingress_rule5" {
  security_group_id = tencentcloud_security_group.sg.id
  type              = "ingress"
  cidr_ip           = "0.0.0.0/0"
  ip_protocol       = "ICMP"
  policy            = "ACCEPT"
  description       = "all accept"
}

resource "tencentcloud_security_group_rule" "sg_egress_rule1" {
  security_group_id = tencentcloud_security_group.sg.id
  type              = "egress"
  cidr_ip           = "0.0.0.0/0"
  ip_protocol       = "TCP"
  policy            = "ACCEPT"
  description       = "all accept"
}

resource "tencentcloud_security_group_rule" "sg_egress_rule" {
  security_group_id = tencentcloud_security_group.sg.id
  type              = "egress"
  cidr_ip           = "0.0.0.0/0"
  ip_protocol       = "UDP"
  policy            = "ACCEPT"
  description       = "all accept"
}

resource "tencentcloud_clb_instance" "ingress-lb" {
  address_ip_version           = "ipv4"
  clb_name                     = var.clb_name
  internet_bandwidth_max_out   = 1
  internet_charge_type         = "BANDWIDTH_POSTPAID_BY_HOUR"
  load_balancer_pass_to_target = true
  network_type                 = "OPEN"
  security_groups              = [tencentcloud_security_group.sg.id]
  vpc_id                       = tencentcloud_vpc.vpc.id
}

