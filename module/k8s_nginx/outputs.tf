# Networks
output "nginx_access" {
  value       = format("http://%s/", kubernetes_ingress_v1.test.status.0.load_balancer.0.ingress.0.ip)
}

