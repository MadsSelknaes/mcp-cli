# Installation af n8n-nodes-mcp-client på Lokal n8n Installation

Denne guide hjælper dig med at installere `n8n-nodes-mcp-client` på din eksisterende lokale n8n installation.

## 🔍 Find din n8n Installation

Først skal du finde hvor n8n er installeret på dit system:

### Hvis n8n er installeret globalt med npm:
```bash
# Find n8n installation sti
npm list -g n8n --depth=0
# eller
which n8n
```

### Hvis n8n er installeret med npx:
```bash
# n8n kører normalt fra ~/.npm/_npx/
ls ~/.npm/_npx/
```

## 📦 Installation Metoder

### Metode 1: Global Installation (Anbefalet)

Hvis n8n er installeret globalt, installer MCP client globalt også:

```bash
# Installer n8n-nodes-mcp-client globalt
npm install -g n8n-nodes-mcp-client

# Eller med yarn
yarn global add n8n-nodes-mcp-client
```

### Metode 2: Lokal Installation i n8n Directory

Find n8n's installation directory og installer der:

```bash
# Find n8n directory
npm root -g

# Naviger til n8n directory
cd $(npm root -g)/n8n

# Installer MCP client
npm install n8n-nodes-mcp-client
```

### Metode 3: Custom Nodes Directory

n8n kan også loade custom nodes fra en specifik mappe:

```bash
# Opret custom nodes directory
mkdir -p ~/.n8n/custom

# Installer i custom directory
cd ~/.n8n/custom
npm install n8n-nodes-mcp-client
```

## 🔧 Konfiguration af n8n

### Miljøvariabler

Sæt miljøvariablen for at fortælle n8n hvor custom nodes er:

```bash
# Linux/macOS
export N8N_CUSTOM_EXTENSIONS=~/.n8n/custom

# Windows (PowerShell)
$env:N8N_CUSTOM_EXTENSIONS="$HOME\.n8n\custom"

# Windows (Command Prompt)
set N8N_CUSTOM_EXTENSIONS=%USERPROFILE%\.n8n\custom
```

### Start n8n med Custom Nodes

```bash
# Start n8n med custom nodes aktiveret
N8N_CUSTOM_EXTENSIONS=~/.n8n/custom n8n start

# Eller hvis miljøvariablen allerede er sat
n8n start
```

## 🚀 Verificer Installation

1. **Start n8n:**
   ```bash
   n8n start
   ```

2. **Åbn n8n i browser:**
   - Gå til http://localhost:5678

3. **Check for MCP nodes:**
   - Opret en ny workflow
   - Kig efter "MCP" eller "Model Context Protocol" nodes i node paletten
   - Nodes skulle være tilgængelige under kategorier som "Advanced" eller "Integration"

## 🔄 Genstart n8n

Efter installation skal n8n genstartes for at loade de nye nodes:

```bash
# Stop n8n (Ctrl+C hvis det kører i terminalen)
# Derefter start igen
n8n start
```

## 📋 Fejlfinding

### Node ikke synlig i paletten

1. **Check installation:**
   ```bash
   npm list -g n8n-nodes-mcp-client
   # eller
   npm list n8n-nodes-mcp-client
   ```

2. **Check n8n logs:**
   ```bash
   # Start n8n med debug logging
   N8N_LOG_LEVEL=debug n8n start
   ```

3. **Clear n8n cache:**
   ```bash
   # Slet n8n cache
   rm -rf ~/.n8n/.cache
   ```

### Permission fejl

Hvis du får permission fejl:

```bash
# Linux/macOS - brug sudo for global installation
sudo npm install -g n8n-nodes-mcp-client

# Eller skift npm prefix
npm config set prefix ~/.npm-global
export PATH=~/.npm-global/bin:$PATH
npm install -g n8n-nodes-mcp-client
```

### n8n finder ikke custom nodes

1. **Check miljøvariabel:**
   ```bash
   echo $N8N_CUSTOM_EXTENSIONS
   ```

2. **Check directory struktur:**
   ```bash
   ls -la ~/.n8n/custom/node_modules/
   ```

3. **Alternativ installation sti:**
   ```bash
   # Installer direkte i n8n's node_modules
   cd $(npm root -g)
   npm install n8n-nodes-mcp-client
   ```

## 🎯 Hurtig Installation Script

Gem dette som `install-mcp-client.sh`:

```bash
#!/bin/bash
set -e

echo "🚀 Installerer n8n-nodes-mcp-client..."

# Prøv global installation først
if npm install -g n8n-nodes-mcp-client; then
    echo "✅ Global installation lykkedes"
else
    echo "⚠️ Global installation fejlede, prøver lokal installation..."
    
    # Opret custom directory
    mkdir -p ~/.n8n/custom
    cd ~/.n8n/custom
    
    # Installer lokalt
    npm install n8n-nodes-mcp-client
    
    echo "✅ Lokal installation lykkedes"
    echo "📝 Husk at sætte miljøvariabel: N8N_CUSTOM_EXTENSIONS=~/.n8n/custom"
fi

echo "🔄 Genstart n8n for at loade de nye nodes"
echo "🌐 Åbn http://localhost:5678 og kig efter MCP nodes i paletten"
```

Kør scriptet:
```bash
chmod +x install-mcp-client.sh
./install-mcp-client.sh
```

## 📞 Support

Hvis du stadig har problemer:

1. Check n8n dokumentation: https://docs.n8n.io/integrations/community-nodes/
2. Check n8n-nodes-mcp-client på npm: https://www.npmjs.com/package/n8n-nodes-mcp-client
3. n8n Community forum: https://community.n8n.io/