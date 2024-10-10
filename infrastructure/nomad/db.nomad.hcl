job "db-service" {
  datacenters = ["dc1"]

  group "db-group" {
    task "postgres" {
      driver = "docker"

      config {
        image = "postgres:latest"
        port_map {
          db = 5432
        }
      }

      service {
        name = "postgres"
        tags = ["db"]
        port = "db"
      }
    }
  }
}