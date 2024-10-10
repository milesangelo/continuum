FROM hashicorp/nomad:latest
COPY nomad.hcl /etc/nomad.d/
CMD ["nomad", "agent", "-dev", "-config=/etc/nomad.d/nomad.hcl"]