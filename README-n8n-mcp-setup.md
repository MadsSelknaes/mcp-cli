# n8n with MCP Client Node Setup

This setup allows you to run n8n locally with Docker and install the `n8n-nodes-mcp-client` package for Model Context Protocol integration.

## Prerequisites

- Docker installed on your system
- Docker Compose installed
- At least 2GB of available RAM
- Port 5678 available (or modify the port in docker-compose.yml)

## Quick Start

1. **Run the setup script:**
   ```bash
   ./setup-n8n-mcp.sh
   ```

2. **Choose installation method:**
   - Option 1: Runtime installation (recommended for testing)
   - Option 2: Custom Docker image (recommended for production)

3. **Access n8n:**
   - URL: http://localhost:5678
   - Username: `admin`
   - Password: `password`

## Manual Setup Options

### Option 1: Runtime Installation

Uses the standard n8n Docker image and installs the MCP client node on startup:

```bash
docker-compose up -d
```

### Option 2: Custom Docker Image

Builds a custom Docker image with the MCP client node pre-installed:

```bash
docker-compose -f docker-compose.custom.yml up --build -d
```

## Configuration

### Environment Variables

The Docker Compose files include these key environment variables:

- `N8N_BASIC_AUTH_ACTIVE=true` - Enables basic authentication
- `N8N_BASIC_AUTH_USER=admin` - Sets username
- `N8N_BASIC_AUTH_PASSWORD=password` - Sets password (change this!)
- `N8N_HOST=localhost` - Sets the host
- `N8N_PORT=5678` - Sets the port

### Volumes

- `n8n_data` - Persistent storage for n8n data
- `./custom-nodes` - Custom node modules
- `./workflows` - Workflow files
- `./credentials` - Credential files

## Using the MCP Client Node

Once n8n is running:

1. Create a new workflow
2. Look for MCP-related nodes in the node palette
3. The `n8n-nodes-mcp-client` should provide nodes for:
   - Connecting to MCP servers
   - Executing MCP tools
   - Managing MCP resources

## Troubleshooting

### Check if n8n is running
```bash
curl http://localhost:5678
```

### View logs
```bash
docker-compose logs -f
```

### Restart n8n
```bash
docker-compose restart
```

### Check installed packages
```bash
docker exec -it n8n npm list -g --depth=0
```

### Install additional packages
```bash
docker exec -it n8n npm install -g <package-name>
```

## Security Notes

⚠️ **Important**: Change the default password before using in production!

1. Update `N8N_BASIC_AUTH_PASSWORD` in the docker-compose.yml file
2. Consider using environment files (.env) for sensitive data
3. Use HTTPS in production environments

## Updating

To update n8n and the MCP client node:

```bash
# Pull latest images
docker-compose pull

# Restart with new images
docker-compose up -d

# Or for custom image
docker-compose -f docker-compose.custom.yml up --build -d
```

## Stopping n8n

```bash
docker-compose down
```

To also remove volumes (⚠️ this will delete all your workflows and data):
```bash
docker-compose down -v
```

## Support

- n8n Documentation: https://docs.n8n.io/
- n8n Community: https://community.n8n.io/
- MCP Specification: https://spec.modelcontextprotocol.io/
- Docker Documentation: https://docs.docker.com/