terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {}

resource "docker_network" "jenkins_net_ruby" {
  name = "jenkins_net_ruby"
}

resource "docker_volume" "jenkins_home_ruby" {
  name = "jenkins_home_ruby"
}

resource "docker_volume" "docker_certs_ruby" {
  name = "docker_certs_ruby"
}

resource "docker_image" "jenkins_custom_ruby" {
  name = "jenkins-custom-ruby:latest"
  build {
    context    = "${path.module}/."
    dockerfile = "Dockerfile"
  }
}

resource "docker_container" "jenkins_ruby" {
  name  = "jenkins_ruby"
  image = docker_image.jenkins_custom_ruby.name
  restart = "unless-stopped"

  ports {
    internal = 8080
    external = 8080
  }

  ports {
    internal = 50000
    external = 50000
  }

  env = [
    "DOCKER_HOST=tcp://docker_ruby:2376",
    "DOCKER_CERT_PATH=/certs/client",
    "DOCKER_TLS_VERIFY=1"
  ]

  volumes {
    volume_name    = docker_volume.jenkins_home_ruby.name
    container_path = "/var/jenkins_home"
  }

  volumes {
    volume_name    = docker_volume.docker_certs_ruby.name
    container_path = "/certs/client"
    read_only      = true
  }

  networks_advanced {
    name = docker_network.jenkins_net_ruby.name
  }
}

resource "docker_container" "docker_ruby" {
  name  = "docker_ruby"
  image = "docker:dind"
  restart = "unless-stopped"
  privileged = true

  env = [
    "DOCKER_TLS_CERTDIR=/certs"
  ]

  ports {
    internal = 3000
    external = 3000
  }

  ports {
    internal = 5000
    external = 5000
  }

  volumes {
    volume_name    = docker_volume.docker_certs_ruby.name
    container_path = "/certs/client"
  }

  networks_advanced {
    name = docker_network.jenkins_net_ruby.name
  }
}
