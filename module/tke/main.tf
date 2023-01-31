resource "tencentcloud_kubernetes_cluster" "managed_cluster" {
  vpc_id                  = tencentcloud_vpc.vpc.id
  cluster_cidr            = var.cluster_cidr
  cluster_name            = var.cluster_name
  cluster_deploy_type     = "MANAGED_CLUSTER"
  cluster_version         = var.cluster_version

  tags = var.tags
}

resource "tencentcloud_kubernetes_node_pool" "nodepool" {
  name                     = var.node_pool_name
  cluster_id               = tencentcloud_kubernetes_cluster.managed_cluster.id 
  max_size                 = var.node_pool_max_size
  min_size                 = var.node_pool_min_size
  vpc_id                   = tencentcloud_vpc.vpc.id
  subnet_ids               = [tencentcloud_subnet.sub.id]
  retry_policy             = "INCREMENTAL_INTERVALS"
  delete_keep_instance     = false
  desired_capacity         = var.node_pool_desired_size
  enable_auto_scale        = var.node_pool_auto_scale
  multi_zone_subnet_policy = "EQUALITY"

  auto_scaling_config {
    instance_type      = var.node_pool_instance_type
    system_disk_type   = "CLOUD_PREMIUM"
    system_disk_size   = "50"
    security_group_ids = [tencentcloud_security_group.sg.id]

    data_disk {
      disk_type = "CLOUD_PREMIUM"
      disk_size = 50
    }

    internet_charge_type       = "TRAFFIC_POSTPAID_BY_HOUR"
    internet_max_bandwidth_out = 10
    public_ip_assigned         = true
    password                   = "test123#"
    enhanced_security_service  = false
    enhanced_monitor_service   = false
  }

  labels = var.tags

  node_config {
    extra_args = [
      "root-dir=/var/lib/kubelet"
    ]
  }
}

# 开通内、外网访问
resource "tencentcloud_kubernetes_cluster_endpoint" "ep" {
  cluster_id = tencentcloud_kubernetes_cluster.managed_cluster.id
  cluster_intranet = true
  cluster_intranet_subnet_id = tencentcloud_subnet.sub.id
  cluster_internet = true
  cluster_internet_security_group = tencentcloud_security_group.sg.id
}

resource "tencentcloud_kubernetes_addon_attachment" "addon_cfs" {
  depends_on = [
    tencentcloud_kubernetes_node_pool.nodepool,
  ]
  cluster_id   = tencentcloud_kubernetes_cluster.managed_cluster.id
  name         = "cfs"
  request_body = <<EOF
  {
    "spec":{
        "chart":{
            "chartName":"cfs",
            "chartVersion":"1.0.8"
        },
        "values":{
            "rawValuesType":"json",
            "values":[
              "rootdir=/var/lib/kubelet"
            ]
        }
    }
  }
EOF
}

