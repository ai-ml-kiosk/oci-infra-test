variable "tenancy_ocid" { type = string }
variable "user_ocid" { type = string }
variable "fingerprint" { type = string }
variable "private_key_path" { type = string }
variable "region" {
  type = string
}

variable "compartment_id" {
  type        = string
  description = "Target OCI Compartment OCID"
}

variable "vcn_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "oke_lb_public_subnet_newbits" {
  type        = number
  description = "Additional subnet bits used to carve the OKE public load balancer subnet from vcn_cidr. Added on 2026-06-09T14:41:42+1000."
  default     = 8
}

variable "oke_lb_public_subnet_netnum" {
  type        = number
  description = "Subnet number used with vcn_cidr and oke_lb_public_subnet_newbits for the OKE public load balancer subnet. Added on 2026-06-09T14:41:42+1000."
  default     = 10
}

variable "oke_lb_public_subnet_dns_label" {
  type        = string
  description = "DNS label for the OKE public load balancer subnet. Added on 2026-06-09T14:41:42+1000."
  default     = "okelbpub"
}

variable "oke_lb_public_subnet_prohibit_public_ip_on_vnic" {
  type        = bool
  description = "Whether to prohibit public IP assignment on VNICs in the OKE public load balancer subnet. Added on 2026-06-09T14:41:42+1000."
  default     = false
}
