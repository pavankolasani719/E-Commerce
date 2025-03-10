output "docker_image" {
  value = docker_image.flask_app.name
}

output "service_endpoint" {
  value = kubernetes_service.flask_service.metadata[0].name
}
