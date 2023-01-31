# Basic
variable "k8s_namespace" {
  type        = string
  default     = "nginx"
  description = "k8s name space"
}

variable "subnet_id" {
  type        = string
  default     = ""
  description = "cluster subnet id"
}

variable "vpc_id" {
  type        = string
  default     = ""
  description = "cluster vpc id"
}

variable "storage_availability_zone" {
  type        = string
  default     = ""
  description = "cluster vpc id"
}

variable "clb_ingress_id" {
  type        = string
  default     = ""
  description = "clb id"
}

