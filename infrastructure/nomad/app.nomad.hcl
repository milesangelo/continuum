job "dotnet-api" {
  datacenters = ["dc1"]

  group "api-group" {
    count = 1

    task "api" {
      driver = "docker"
      config {
        image = "your-docker-registry/your-dotnet-api-service:latest"
        port_map {
          http = 80
        }
      }

      template {
        data = <<EOF
          {
            "ConnectionStrings": {
              "DefaultConnection": "{{ with secret "vault/db/creds" }}{{ .Data.username }}:{{ .Data.password }}@db-service{{ end }}"
            }
          }
        EOF
        destination = "/config/settings.json"
      }
    }

    service {
      name = "your-dotnet-api-service"
      port = "http"
    }
  }
}