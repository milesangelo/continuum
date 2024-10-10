job "dotnet-api" {
  datacenters = ["dc1"]

  group "api-group" {
    count = 1

    task "api" {
      driver = "docker"

      config {
        image = "your-docker-registry/your-dotnet-api-service:{{ .Env.SERVICE_VERSION }}"
        port_map {
          http = 80
        }
      }

      resources {
        cpu    = 500
        memory = 256
      }

      # Inject secrets via Vault
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
  }
}