@echo off
setlocal enabledelayedexpansion

echo 🚀 Installerer n8n-nodes-mcp-client...

:: Tjek om npm er tilgængeligt
npm --version >nul 2>&1
if errorlevel 1 (
    echo ❌ npm er ikke installeret. Installer Node.js og npm først.
    pause
    exit /b 1
)

:: Tjek om n8n er installeret
n8n --version >nul 2>&1
if errorlevel 1 (
    npm list -g n8n >nul 2>&1
    if errorlevel 1 (
        echo ❌ n8n er ikke installeret. Installer n8n først med: npm install -g n8n
        pause
        exit /b 1
    )
)

echo ✅ npm og n8n er tilgængelige

:: Prøv global installation først
echo 📦 Prøver global installation...
npm install -g n8n-nodes-mcp-client
if errorlevel 1 (
    echo ⚠️ Global installation fejlede, prøver lokal installation...
    
    :: Opret custom directory
    echo 📁 Opretter custom nodes directory...
    if not exist "%USERPROFILE%\.n8n\custom" mkdir "%USERPROFILE%\.n8n\custom"
    cd /d "%USERPROFILE%\.n8n\custom"
    
    :: Initialiser package.json hvis den ikke findes
    if not exist package.json (
        echo 📄 Opretter package.json...
        echo {"name": "n8n-custom-nodes", "version": "1.0.0"} > package.json
    )
    
    :: Installer lokalt
    echo 📦 Installerer lokalt...
    npm install n8n-nodes-mcp-client
    if errorlevel 1 (
        echo ❌ Begge installationsmetoder fejlede. Check fejlmeddelelser ovenfor.
        pause
        exit /b 1
    ) else (
        echo ✅ Lokal installation lykkedes!
        set INSTALL_METHOD=local
        
        :: Sæt miljøvariabel besked
        echo.
        echo 📝 VIGTIGT: Sæt denne miljøvariabel før du starter n8n:
        echo    set N8N_CUSTOM_EXTENSIONS=%USERPROFILE%\.n8n\custom
        echo.
        echo    Eller start n8n med:
        echo    set N8N_CUSTOM_EXTENSIONS=%USERPROFILE%\.n8n\custom ^&^& n8n start
    )
) else (
    echo ✅ Global installation lykkedes!
    set INSTALL_METHOD=global
)

echo.
echo 🔍 Verificerer installation...
if "!INSTALL_METHOD!"=="global" (
    npm list -g n8n-nodes-mcp-client >nul 2>&1
    if errorlevel 1 (
        echo ⚠️ Kunne ikke verificere global installation
    ) else (
        echo ✅ n8n-nodes-mcp-client er installeret globalt
    )
) else (
    if exist "%USERPROFILE%\.n8n\custom\node_modules\n8n-nodes-mcp-client" (
        echo ✅ n8n-nodes-mcp-client er installeret lokalt
    ) else (
        echo ⚠️ Kunne ikke verificere lokal installation
    )
)

echo.
echo 🎉 Installation fuldført!
echo.
echo 📋 Næste trin:
echo 1. 🔄 Genstart n8n hvis det kører
echo 2. 🌐 Åbn http://localhost:5678
echo 3. 🔍 Kig efter MCP nodes i node paletten
echo 4. 📝 MCP nodes skulle være under kategorier som 'Advanced' eller 'Integration'
echo.

if "!INSTALL_METHOD!"=="local" (
    echo ⚠️ HUSK: Sæt miljøvariablen N8N_CUSTOM_EXTENSIONS=%USERPROFILE%\.n8n\custom
)

echo 🚀 Start n8n med: n8n start
pause