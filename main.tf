terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
    tencentcloud = {
      source  = "tencentcloudstack/tencentcloud"
      version = ">=1.78.1"
    }
  }
}

provider "tencentcloud" {
  region     = var.region
}

module "tencentcloud_tke" {
	source = "./module/tke"

    availability_zone = var.availability_zone	
}

provider "kubernetes" {
  host                   = module.tencentcloud_tke.cluster_endpoint
  cluster_ca_certificate = module.tencentcloud_tke.cluster_ca_certificate
  client_key             = base64decode(module.tencentcloud_tke.client_key)
  client_certificate     = base64decode(module.tencentcloud_tke.client_certificate)
}

module "kubernetes_nginx" {
	source = "./module/k8s_nginx"
    storage_availability_zone = var.availability_zone	
    subnet_id = module.tencentcloud_tke.subnet_id
    vpc_id = module.tencentcloud_tke.vpc_id
	clb_ingress_id = module.tencentcloud_tke.clb_id
    depends_on = [
		module.tencentcloud_tke
    ]
}

output "nginx" {
	value = module.kubernetes_nginx.nginx_access
}

