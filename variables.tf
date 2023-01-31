variable "availability_zone" {
  type        = string
  default     = "ap-singapore-3"
  description = "Specify available zone of VPC subnet and TKE nodes."
}

variable "region" {
  type = string
  default = "ap-singapore"
  description = "Specify region of VPC subnet and TKE nodes."
}