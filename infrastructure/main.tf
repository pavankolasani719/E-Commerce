provider "kubernetes" {
  config_path = var.kube_config_path
}

resource "kubernetes_deployment" "backend" {
  metadata {
    name = "backend"
    labels = { app = "ecommerce" }
  }
  spec {
    replicas = 2
    selector { match_labels = { app = "backend" } }
    template {
      metadata { labels = { app = "backend" } }
      spec {
        container {
          image = "pavankolasani719/backend:latest"
          name  = "backend"
          port {
            container_port = 5000
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "backend" {
  metadata { name = "backend" }
  spec {
    selector = { app = "backend" }
    port {
      port        = 80
      target_port = 5000
    }
  }
}
