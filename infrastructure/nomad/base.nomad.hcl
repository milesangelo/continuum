job "base-config" {
  datacenters = ["dc1"]

  group "common-group" {
    network {
      port "http" {
        static = 8080
      }
    }
  }
}