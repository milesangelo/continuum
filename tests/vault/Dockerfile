FROM hashicorp/vault:latest
COPY vault.hcl /vault/config/
CMD ["vault", "server", "-config=/vault/config/vault.hcl"]