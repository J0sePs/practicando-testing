# Script para verificar instalaciones de Python
# Ejecutar en PowerShell: .\check_python_versions.ps1

Write-Host "`n=== Verificando Versiones de Python Instaladas ===" -ForegroundColor Cyan
Write-Host ""

# Verificar Python Launcher
Write-Host "1. Python Launcher (py):" -ForegroundColor Yellow
try {
    py -0
    Write-Host "   ✓ Python Launcher funcionando`n" -ForegroundColor Green
} catch {
    Write-Host "   ✗ Python Launcher no encontrado`n" -ForegroundColor Red
}

# Verificar versiones específicas
Write-Host "2. Verificando versiones específicas:" -ForegroundColor Yellow

$versions = @("3.9", "3.10", "3.11", "3.12", "3.13")

foreach ($version in $versions) {
    Write-Host "   Python $version" -NoNewline
    try {
        $output = & py "-$version" --version 2>&1
        if ($output -match "Python") {
            Write-Host " ✓ " -ForegroundColor Green -NoNewline
            Write-Host "$output"
        } else {
            Write-Host " ✗ No instalado" -ForegroundColor Red
        }
    } catch {
        Write-Host " ✗ No instalado" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "3. Ubicaciones de Python:" -ForegroundColor Yellow
try {
    $pythonPaths = where.exe python 2>$null
    if ($pythonPaths) {
        foreach ($path in $pythonPaths) {
            Write-Host "   - $path" -ForegroundColor Cyan
        }
    } else {
        Write-Host "   No se encontraron instalaciones de Python en PATH" -ForegroundColor Red
    }
} catch {
    Write-Host "   Error al buscar Python" -ForegroundColor Red
}

Write-Host ""
Write-Host "4. Estado de tox:" -ForegroundColor Yellow
try {
    $toxVersion = & "C:/Users/josef/.virtualenvs/TAREA-od1x3rHy/Scripts/tox.exe" --version 2>&1
    if ($toxVersion) {
        Write-Host "   ✓ tox instalado: $toxVersion" -ForegroundColor Green
    }
} catch {
    Write-Host "   ✗ tox no encontrado" -ForegroundColor Red
}

Write-Host ""
Write-Host "=== Resumen ===" -ForegroundColor Cyan
Write-Host ""

# Contar versiones instaladas
$installedCount = 0
foreach ($version in $versions) {
    try {
        $output = & py "-$version" --version 2>&1
        if ($output -match "Python") {
            $installedCount++
        }
    } catch {}
}

Write-Host "Versiones de Python instaladas: $installedCount de $($versions.Count)" -ForegroundColor $(if ($installedCount -ge 2) { "Green" } else { "Yellow" })

if ($installedCount -lt 2) {
    Write-Host ""
    Write-Host "⚠️  Recomendación:" -ForegroundColor Yellow
    Write-Host "   Para completar el Ejercicio 6 al 100%, instala al menos una versión más de Python."
    Write-Host "   Descarga Python 3.12.7 desde: https://www.python.org/downloads/release/python-3127/"
    Write-Host ""
}

Write-Host ""
Write-Host "Para instalar más versiones de Python:" -ForegroundColor Cyan
Write-Host "1. Visita: https://www.python.org/downloads/" -ForegroundColor White
Write-Host "2. Descarga la versión deseada" -ForegroundColor White
Write-Host "3. Durante la instalación, marca 'Add Python to PATH'" -ForegroundColor White
Write-Host "4. Ejecuta este script nuevamente para verificar" -ForegroundColor White
Write-Host ""
