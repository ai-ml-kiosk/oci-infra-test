resource "oci_core_vcn" "k8s_vcn" {
  compartment_id = var.compartment_id
  cidr_block     = var.vcn_cidr
  display_name   = "prod-core-vcn"
  dns_label      = "prodcorevcn"
}

resource "oci_core_internet_gateway" "igw" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.k8s_vcn.id
  display_name   = "prod-internet-gateway"
  enabled        = true
}

resource "oci_core_route_table" "oke_lb_public" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.k8s_vcn.id
  display_name   = "prod-oke-lb-public-rt"
  freeform_tags = {
    change_description = "Added OKE public load balancer route table on 2026-06-09T14:41:42+1000"
  }

  route_rules {
    network_entity_id = oci_core_internet_gateway.igw.id
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
  }
}

resource "oci_core_subnet" "oke_lb_public" {
  compartment_id             = var.compartment_id
  vcn_id                     = oci_core_vcn.k8s_vcn.id
  cidr_block                 = cidrsubnet(var.vcn_cidr, var.oke_lb_public_subnet_newbits, var.oke_lb_public_subnet_netnum)
  display_name               = "prod-oke-lb-public-subnet"
  dns_label                  = var.oke_lb_public_subnet_dns_label
  prohibit_public_ip_on_vnic = var.oke_lb_public_subnet_prohibit_public_ip_on_vnic
  route_table_id             = oci_core_route_table.oke_lb_public.id
  freeform_tags = {
    change_description = "Added OKE public load balancer subnet on 2026-06-09T14:41:42+1000"
  }
}
