
# Define the Docker image name and version
variable "docker_image_name" {
  description = "The Docker image name to be pushed to Docker Hub"
  type        = string
  default     = "yourusername/flask-ecommerce"
}

variable "docker_image_version" {
  description = "The Docker image version (tag)"
  type        = string
  default     = "latest"
}

# Define Kubernetes Cluster URL and other variables if needed
variable "k8s_cluster_url" {
  description = "The URL for the Kubernetes cluster"
  type        = string
  default     = "https://localhost:6443"
}

# Define Docker Hub username and password for registry access (if private)
variable "docker_hub_username" {
  description = "Docker Hub username"
  type        = string
  default     = "pavankolasani719"  # Set default value (optional)
}

variable "docker_hub_password" {
  description = "Docker Hub password"
  type        = string
  sensitive   = true
  default     = "Kolasani.9"  # Set default value (optional, but not recommended)
}

