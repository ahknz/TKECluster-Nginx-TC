# Simple Nginx App with TKE Cluster on TC

This Terraform create a Tencent Cloud TKE cluster and deploy a simple Nginx application.

## Prerequisites
You must have the following ready

- Secret ID
- Secret Key 
- Terraform
- Tencent Cloud Account

To create Secret ID and Secret Key, please refer to https://www.tencentcloud.com/document/product/598/32675?lang=en 

For Terraform setup, please refer to https://developer.hashicorp.com/terraform/downloads 

## Steps 
 - TKE Cluster creation : networking, cluster, CAM roles, 
 - K8s Nginx creation : K8s provider, security group, resources

## How to run
```
$ export TENCENTCLOUD_SECRET_ID="my-secret-id"
$ export TENCENTCLOUD_SECRET_KEY="my-secret-key"

terraform init
terraform plan
terraform apply
```
