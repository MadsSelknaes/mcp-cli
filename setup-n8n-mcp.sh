#!/bin/bash

# Setup script for n8n with MCP client node
set -e

echo "🚀 Setting up n8n with MCP client node..."

# Create necessary directories
echo "📁 Creating directories..."
mkdir -p custom-nodes
mkdir -p workflows
mkdir -p credentials

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Please install Docker first."
    echo "Visit: https://docs.docker.com/get-docker/"
    exit 1
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null && ! docker compose version &> /dev/null; then
    echo "❌ Docker Compose is not installed. Please install Docker Compose first."
    echo "Visit: https://docs.docker.com/compose/install/"
    exit 1
fi

echo "✅ Docker and Docker Compose are available"

# Option 1: Use pre-built n8n image with runtime installation
echo ""
echo "Choose installation method:"
echo "1) Runtime installation (installs MCP client on startup)"
echo "2) Custom Docker image (builds image with MCP client pre-installed)"
echo ""
read -p "Enter your choice (1 or 2): " choice

case $choice in
    1)
        echo "🐳 Starting n8n with runtime MCP client installation..."
        docker-compose up -d
        ;;
    2)
        echo "🔨 Building custom n8n image with MCP client..."
        docker-compose -f docker-compose.custom.yml up --build -d
        ;;
    *)
        echo "❌ Invalid choice. Please run the script again and choose 1 or 2."
        exit 1
        ;;
esac

echo ""
echo "⏳ Waiting for n8n to start..."
sleep 10

# Check if n8n is running
if curl -s http://localhost:5678 > /dev/null; then
    echo "✅ n8n is running successfully!"
    echo ""
    echo "🌐 Access n8n at: http://localhost:5678"
    echo "👤 Username: admin"
    echo "🔑 Password: password"
    echo ""
    echo "📦 The MCP client node should be available in the node palette."
    echo "🔍 Look for 'MCP' or 'Model Context Protocol' nodes when creating workflows."
else
    echo "❌ n8n might not be ready yet. Please wait a few more seconds and check http://localhost:5678"
fi

echo ""
echo "📋 Useful commands:"
echo "  View logs: docker-compose logs -f"
echo "  Stop n8n: docker-compose down"
echo "  Restart n8n: docker-compose restart"
echo "  Update n8n: docker-compose pull && docker-compose up -d"