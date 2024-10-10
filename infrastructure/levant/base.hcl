job "common" {
  datacenters = ["dc1"]
  region = "global"

  group "common-group" {
    task "setup" {
      driver = "docker"

      config {
        image = "busybox"
        command = "sleep"
        args = ["3600"]
      }

      resources {
        cpu    = 100
        memory = 128
      }
    }
  }
}