# Terraform provider for Docker
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.15.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}

# Build Docker Image for Flask App (from the Dockerfile)
resource "docker_image" "flask_app" {
  name = "pavankolasani719/flask-ecommerce:latest"
  build {
    path       = "../frontend"
    dockerfile = "../frontend/Dockerfile"
  }
}

# Docker Registry Credentials (optional, if you need to authenticate to Docker Hub)
resource "docker_registry_image" "flask_app" {
  name = docker_image.flask_app.name
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
          image = docker_image.flask_app.name
          port {
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
