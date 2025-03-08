# Terraform provider for Docker
terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "2.15.0" # Use the version you need
    }
  }
}

# Provider for Kubernetes (local k3d cluster)
provider "kubernetes" {
  host                   = "https://localhost:6443"   # Assuming k3d is set up with default port
  cluster_ca_certificate = base64decode(data.aws_secretsmanager_secret.certificates.secret_string)
  token                  = data.aws_secretsmanager_secret.kube_token.secret_string
}

# Build Docker Image for Flask App (from the Dockerfile)
resource "docker_image" "flask_app" {
  name = "yourusername/flask-ecommerce:latest"
  build {
    context    = "${path.module}/frontend"  # Assuming frontend has a Dockerfile
    dockerfile = "${path.module}/frontend/Dockerfile"
  }
}

# Kubernetes Deployment for Flask App
resource "kubernetes_deployment" "flask_deployment" {
  metadata {
    name      = "flask-app-deployment"
    namespace = "default"
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "flask-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "flask-app"
        }
      }

      spec {
        container {
          name  = "flask-container"
          image = docker_image.flask_app.image_id
          ports {
            container_port = 5000
          }
        }
      }
    }
  }
}

# Kubernetes Service for Flask App
resource "kubernetes_service" "flask_service" {
  metadata {
    name      = "flask-service"
    namespace = "default"
  }

  spec {
    selector = {
      app = "flask-app"
    }

    port {
      port        = 80
      target_port = 5000
    }
  }
}

# Docker Hub Credentials (optional, if you need to authenticate to Docker Hub)
resource "docker_registry_image" "flask_app" {
  name      = "yourusername/flask-ecommerce:latest"
  image_url = docker_image.flask_app.image_id
}
