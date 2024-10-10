#!/bin/bash

# Define variables
NOMAD_URL="http://localhost:4646"
CONSUL_URL="http://localhost:8500"
VAULT_URL="http://localhost:8200"
VAULT_TOKEN="root"  # In production, use a secure token retrieval process

DEPLOY_ROOT="./infrastructure"

# Step 1: Start Docker Compose services (Nomad, Vault, Consul, etc.)
echo "Starting Docker Compose services..."
cd $DEPLOY_ROOT
docker-compose up -d 

# Step 2: Wait for services to start (Nomad, Vault, Consul)
echo "Waiting for services to start..."
sleep 10  # Adjust if necessary

# Step 3: Configure Vault
echo "Configuring Vault..."
# Login to Vault
vault login $VAULT_TOKEN

# Add Vault policies
vault policy write api-policy vault/policies/api-policy.hcl

# Add secrets (for example, database credentials)
vault kv put db/creds username=admin password=adminpassword

# Step 4: Register services with Consul
echo "Registering services in Consul..."
curl --request PUT --data @consul/api-service.json $CONSUL_URL/v1/agent/service/register

# Step 5: Deploy Nomad jobs using Levant
# Execute Levant inside the container using Docker
echo "Deploying Nomad jobs with Levant (inside Docker container)..."
docker exec levant levant deploy /levant/app.hcl

# Step 6: Confirm deployment
echo "Checking deployment status on Nomad..."
nomad job status dotnet-api

echo "Deployment completed!"