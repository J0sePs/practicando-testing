# Script de configuración automatizada para Git y GitHub
# Ejecutar en PowerShell: .\setup_git_github.ps1

param(
    [string]$RepoName = "calculator-testing-project",
    [string]$RepoDescription = "Python calculator project with pytest, tox, and CI/CD"
)

Write-Host "`n╔═══════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║   GitHub Actions CI/CD Setup Script                          ║" -ForegroundColor Cyan
Write-Host "╚═══════════════════════════════════════════════════════════════╝`n" -ForegroundColor Cyan

# Función para mostrar errores
function Show-Error {
    param([string]$Message)
    Write-Host "✗ ERROR: $Message" -ForegroundColor Red
    Write-Host ""
}

# Función para mostrar éxitos
function Show-Success {
    param([string]$Message)
    Write-Host "✓ $Message" -ForegroundColor Green
}

# Función para mostrar información
function Show-Info {
    param([string]$Message)
    Write-Host "ℹ $Message" -ForegroundColor Yellow
}

# Verificar si Git está instalado
Write-Host "1. Verificando instalación de Git..." -ForegroundColor Cyan
try {
    $gitVersion = git --version
    Show-Success "Git está instalado: $gitVersion"
} catch {
    Show-Error "Git no está instalado. Por favor instala Git desde: https://git-scm.com/download/win"
    exit 1
}

Write-Host ""

# Verificar configuración de Git
Write-Host "2. Verificando configuración de Git..." -ForegroundColor Cyan
$userName = git config --global user.name
$userEmail = git config --global user.email

if ([string]::IsNullOrEmpty($userName) -or [string]::IsNullOrEmpty($userEmail)) {
    Show-Info "Configuración de Git no encontrada. Configurando..."
    
    $userName = Read-Host "Ingresa tu nombre"
    $userEmail = Read-Host "Ingresa tu email"
    
    git config --global user.name $userName
    git config --global user.email $userEmail
    
    Show-Success "Git configurado correctamente"
} else {
    Show-Success "Git ya está configurado"
    Write-Host "   Nombre: $userName" -ForegroundColor Gray
    Write-Host "   Email: $userEmail" -ForegroundColor Gray
}

Write-Host ""

# Verificar si ya existe un repositorio Git
Write-Host "3. Verificando repositorio Git local..." -ForegroundColor Cyan
if (Test-Path ".git") {
    Show-Info "Repositorio Git ya existe"
    
    $response = Read-Host "¿Deseas reinicializar el repositorio? (y/N)"
    if ($response -eq 'y' -or $response -eq 'Y') {
        Remove-Item -Recurse -Force ".git"
        git init
        Show-Success "Repositorio reinicializado"
    }
} else {
    git init
    Show-Success "Repositorio Git inicializado"
}

Write-Host ""

# Verificar archivos necesarios
Write-Host "4. Verificando archivos necesarios..." -ForegroundColor Cyan

$requiredFiles = @(
    ".github\workflows\ci.yml",
    ".gitignore",
    "requirements.txt",
    "src\calculator.py",
    "tests\test_calculator.py",
    "pytest.ini",
    "tox.ini"
)

$missingFiles = @()
foreach ($file in $requiredFiles) {
    if (Test-Path $file) {
        Show-Success "$file existe"
    } else {
        Show-Error "$file NO EXISTE"
        $missingFiles += $file
    }
}

if ($missingFiles.Count -gt 0) {
    Write-Host ""
    Show-Error "Faltan archivos necesarios. Por favor crea los archivos faltantes antes de continuar."
    exit 1
}

Write-Host ""

# Agregar archivos al staging area
Write-Host "5. Agregando archivos al repositorio..." -ForegroundColor Cyan
git add .
$statusOutput = git status --short
if ($statusOutput) {
    Show-Success "Archivos agregados al staging area"
    Write-Host $statusOutput -ForegroundColor Gray
} else {
    Show-Info "No hay cambios para agregar (ya commiteados)"
}

Write-Host ""

# Hacer commit
Write-Host "6. Creando commit inicial..." -ForegroundColor Cyan
try {
    $commitMessage = "Initial commit: Calculator project with tests and CI/CD setup"
    git commit -m $commitMessage
    Show-Success "Commit creado: $commitMessage"
} catch {
    Show-Info "No hay cambios para commitear o ya fue commiteado"
}

Write-Host ""

# Verificar GitHub CLI
Write-Host "7. Verificando GitHub CLI..." -ForegroundColor Cyan
try {
    $ghVersion = gh --version
    Show-Success "GitHub CLI está instalado"
    
    Write-Host ""
    $useGhCli = Read-Host "¿Deseas crear el repositorio en GitHub automáticamente con GitHub CLI? (y/N)"
    
    if ($useGhCli -eq 'y' -or $useGhCli -eq 'Y') {
        Write-Host ""
        Write-Host "Creando repositorio en GitHub..." -ForegroundColor Cyan
        
        $visibility = Read-Host "¿Repositorio público o privado? (public/private)"
        if ([string]::IsNullOrEmpty($visibility)) {
            $visibility = "public"
        }
        
        try {
            gh repo create $RepoName --$visibility --source=. --remote=origin --description=$RepoDescription
            Show-Success "Repositorio creado en GitHub: $RepoName"
            
            Write-Host ""
            $doPush = Read-Host "¿Deseas hacer push del código ahora? (Y/n)"
            if ($doPush -ne 'n' -and $doPush -ne 'N') {
                git branch -M main
                git push -u origin main
                Show-Success "Código subido a GitHub"
                
                Write-Host ""
                Write-Host "╔═══════════════════════════════════════════════════════════════╗" -ForegroundColor Green
                Write-Host "║   ✅ CONFIGURACIÓN COMPLETADA EXITOSAMENTE                   ║" -ForegroundColor Green
                Write-Host "╚═══════════════════════════════════════════════════════════════╝" -ForegroundColor Green
                Write-Host ""
                
                $ghUser = gh api user --jq .login
                $repoUrl = "https://github.com/$ghUser/$RepoName"
                $actionsUrl = "$repoUrl/actions"
                
                Write-Host "🌐 Repositorio: $repoUrl" -ForegroundColor Cyan
                Write-Host "🚀 GitHub Actions: $actionsUrl" -ForegroundColor Cyan
                Write-Host ""
                
                $openBrowser = Read-Host "¿Deseas abrir GitHub Actions en el navegador? (Y/n)"
                if ($openBrowser -ne 'n' -and $openBrowser -ne 'N') {
                    Start-Process $actionsUrl
                }
            }
        } catch {
            Show-Error "Error al crear repositorio en GitHub: $_"
        }
    }
} catch {
    Show-Info "GitHub CLI no está instalado"
    Write-Host "   Para crear el repositorio manualmente:" -ForegroundColor Yellow
    Write-Host "   1. Ve a https://github.com/new" -ForegroundColor Gray
    Write-Host "   2. Nombre del repositorio: $RepoName" -ForegroundColor Gray
    Write-Host "   3. Descripción: $RepoDescription" -ForegroundColor Gray
    Write-Host "   4. Selecciona público o privado" -ForegroundColor Gray
    Write-Host "   5. NO agregues README, .gitignore, o licencia" -ForegroundColor Gray
    Write-Host "   6. Crea el repositorio" -ForegroundColor Gray
    Write-Host ""
    Write-Host "   Luego ejecuta estos comandos:" -ForegroundColor Yellow
    Write-Host "   git remote add origin https://github.com/TU_USUARIO/$RepoName.git" -ForegroundColor Gray
    Write-Host "   git branch -M main" -ForegroundColor Gray
    Write-Host "   git push -u origin main" -ForegroundColor Gray
}

Write-Host ""
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""

# Mostrar siguiente pasos
Write-Host "📝 SIGUIENTES PASOS:" -ForegroundColor Yellow
Write-Host ""
Write-Host "1. Crea el repositorio en GitHub (si no lo hiciste con GitHub CLI)" -ForegroundColor White
Write-Host "   https://github.com/new" -ForegroundColor Gray
Write-Host ""
Write-Host "2. Conecta el repositorio remoto:" -ForegroundColor White
Write-Host "   git remote add origin https://github.com/TU_USUARIO/$RepoName.git" -ForegroundColor Gray
Write-Host ""
Write-Host "3. Sube el código:" -ForegroundColor White
Write-Host "   git branch -M main" -ForegroundColor Gray
Write-Host "   git push -u origin main" -ForegroundColor Gray
Write-Host ""
Write-Host "4. Ve a GitHub Actions para ver los tests ejecutándose:" -ForegroundColor White
Write-Host "   https://github.com/TU_USUARIO/$RepoName/actions" -ForegroundColor Gray
Write-Host ""

# Resumen de archivos
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""
Write-Host "📁 ARCHIVOS CREADOS/CONFIGURADOS:" -ForegroundColor Yellow
Write-Host ""
Write-Host "✓ .github/workflows/ci.yml    - GitHub Actions workflow" -ForegroundColor Green
Write-Host "✓ .gitignore                   - Archivos ignorados por Git" -ForegroundColor Green
Write-Host "✓ requirements.txt             - Dependencias de Python" -ForegroundColor Green
Write-Host "✓ .git/                        - Repositorio Git inicializado" -ForegroundColor Green
Write-Host ""

# Mostrar estado de Git
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""
Write-Host "📊 ESTADO DE GIT:" -ForegroundColor Yellow
Write-Host ""
git status --short --branch
Write-Host ""
git log --oneline --max-count=5 2>$null
Write-Host ""
