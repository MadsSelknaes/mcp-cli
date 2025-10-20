#!/bin/bash
set -e

echo "🚀 Installerer n8n-nodes-mcp-client..."

# Tjek om npm er tilgængeligt
if ! command -v npm &> /dev/null; then
    echo "❌ npm er ikke installeret. Installer Node.js og npm først."
    exit 1
fi

# Tjek om n8n er installeret
if ! command -v n8n &> /dev/null && ! npm list -g n8n &> /dev/null; then
    echo "❌ n8n er ikke installeret. Installer n8n først med: npm install -g n8n"
    exit 1
fi

echo "✅ npm og n8n er tilgængelige"

# Prøv global installation først
echo "📦 Prøver global installation..."
if npm install -g n8n-nodes-mcp-client; then
    echo "✅ Global installation lykkedes!"
    INSTALL_METHOD="global"
else
    echo "⚠️ Global installation fejlede, prøver lokal installation..."
    
    # Opret custom directory
    echo "📁 Opretter custom nodes directory..."
    mkdir -p ~/.n8n/custom
    cd ~/.n8n/custom
    
    # Initialiser package.json hvis den ikke findes
    if [ ! -f package.json ]; then
        echo "📄 Opretter package.json..."
        npm init -y
    fi
    
    # Installer lokalt
    echo "📦 Installerer lokalt..."
    if npm install n8n-nodes-mcp-client; then
        echo "✅ Lokal installation lykkedes!"
        INSTALL_METHOD="local"
        
        # Sæt miljøvariabel besked
        echo ""
        echo "📝 VIGTIGT: Sæt denne miljøvariabel før du starter n8n:"
        echo "   export N8N_CUSTOM_EXTENSIONS=~/.n8n/custom"
        echo ""
        echo "   Eller start n8n med:"
        echo "   N8N_CUSTOM_EXTENSIONS=~/.n8n/custom n8n start"
    else
        echo "❌ Begge installationsmetoder fejlede. Check fejlmeddelelser ovenfor."
        exit 1
    fi
fi

# Verificer installation
echo ""
echo "🔍 Verificerer installation..."
if [ "$INSTALL_METHOD" = "global" ]; then
    if npm list -g n8n-nodes-mcp-client &> /dev/null; then
        echo "✅ n8n-nodes-mcp-client er installeret globalt"
    else
        echo "⚠️ Kunne ikke verificere global installation"
    fi
else
    if [ -d ~/.n8n/custom/node_modules/n8n-nodes-mcp-client ]; then
        echo "✅ n8n-nodes-mcp-client er installeret lokalt"
    else
        echo "⚠️ Kunne ikke verificere lokal installation"
    fi
fi

echo ""
echo "🎉 Installation fuldført!"
echo ""
echo "📋 Næste trin:"
echo "1. 🔄 Genstart n8n hvis det kører"
echo "2. 🌐 Åbn http://localhost:5678"
echo "3. 🔍 Kig efter MCP nodes i node paletten"
echo "4. 📝 MCP nodes skulle være under kategorier som 'Advanced' eller 'Integration'"
echo ""

if [ "$INSTALL_METHOD" = "local" ]; then
    echo "⚠️ HUSK: Sæt miljøvariablen N8N_CUSTOM_EXTENSIONS=~/.n8n/custom"
fi

echo "🚀 Start n8n med: n8n start"