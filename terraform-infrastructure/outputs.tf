# Output the Docker image name and tag
output "docker_image" {
  value = docker_image.flask_app.image_id
}

# Output the Kubernetes service URL
output "flask_service_url" {
  value = "http://localhost:8080"  # Modify this based on your k3d setup
}

# Output Kubernetes Deployment details
output "flask_deployment_name" {
  value = kubernetes_deployment.flask_deployment.metadata[0].name
}
