# Basic
variable "availability_zone" {
  type        = string
  default     = "ap-singapore-3"
  description = "Specify available zone of VPC subnet and TKE nodes."
}

variable "create_cam_strategy" {
  type        = bool
  default     = true
  description = "Specify whether to create CAM role and relative TKE essential policy. Set to false if you've enable by using TencentCloud Console."
}

variable "tags" {
  type = map(string)
  default = {
    app = "nginx-test"
  }
  description = "Tagged for all associated resource of this module."
}

# Networks
variable "vpc_name" {
  type        = string
  default     = "example-vpc"
  description = "Specify custom VPC Name."
}

variable "subnet_name" {
  type        = string
  default     = "example-subnet"
  description = "Specify custom Subnet Name."
}

variable "eip_name" {
  type        = string
  default     = "example-eip"
  description = "Specify Eip Name."
}

variable "nat_name" {
  type        = string
  default     = "example-nat"
  description = "Specify Nat Name."
}

variable "clb_name" {
  type        = string
  default     = "example-clb"
  description = "Specify Clb Name."
}

variable "security_group_name" {
  type        = string
  default     = "example-security-group"
  description = "Specify custom Security Group Name."
}

variable "route_table_name" {
  type        = string
  default     = "example-route_table"
  description = "Specify Route Table Name."
}

variable "network_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "Specify VPC and subnet CIDR."
}

# TKE
variable "cluster_name" {
  type        = string
  default     = "example-cluster"
  description = "TKE managed cluster name."
}

variable "cluster_version" {
  type        = string
  default     = "1.22.5"
  description = "Cluster kubernetes version."
}

variable "cluster_cidr" {
  type        = string
  default     = "172.16.0.0/22"
  description = "Cluster cidr, conflicts with its subnet."
}

variable "node_pool_instance_type" {
  type        = string
  default     = "SA2.MEDIUM2"
  description = "Cluster node instance type."
}

# node pool
variable "node_pool_name" {
  type        = string
  default     = "example-node"
  description = "TKE managed node pool name."
}

variable "node_pool_max_size" {
  type        = number
  default     = 1
  description = "TKE managed node pool max size."
}

variable "node_pool_min_size" {
  type        = number
  default     = 1
  description = "TKE managed node pool min size."
}

variable "node_pool_desired_size" {
  type        = number
  default     = 1
  description = "TKE managed node pool desired_capacity."
}

variable "node_pool_auto_scale" {
  type        = bool
  default     = false
  description = "TKE managed node pool enable_auto_scale."
}

