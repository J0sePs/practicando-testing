# 🎉 EJERCICIO 7: COMPLETADO - GitHub Actions CI/CD Pipeline

## ✅ Estado: CONFIGURACIÓN COMPLETADA

---

## 📊 Archivos Creados

```
project/
├── .github/
│   └── workflows/
│       └── ci.yml          ✅ CREADO - GitHub Actions workflow
├── .gitignore              ✅ CREADO - Archivos ignorados
├── setup_git_github.ps1    ✅ CREADO - Script de automatización
├── GITHUB_ACTIONS_SETUP.md ✅ CREADO - Guía completa paso a paso
└── README.md               ✅ ACTUALIZADO - Con badges y CI info
```

---

## 🎯 Objetivos Completados

| Tarea | Estado | Detalles |
|-------|--------|----------|
| **Crear directorio .github/workflows/** | ✅ COMPLETO | Estructura creada |
| **Crear archivo ci.yml** | ✅ COMPLETO | Workflow configurado |
| **Configurar trigger en push** | ✅ COMPLETO | Push a main/master/develop |
| **Configurar job con checkout** | ✅ COMPLETO | actions/checkout@v4 |
| **Configurar matrix de Python** | ✅ COMPLETO | Python 3.9, 3.10, 3.11, 3.12, 3.13 |
| **Instalar dependencias** | ✅ COMPLETO | pip install pytest pytest-cov |
| **Ejecutar pytest** | ✅ COMPLETO | pytest --cov=src -v |
| **Crear documentación** | ✅ COMPLETO | Guía completa incluida |

---

## 🚀 ¿Qué Hace el Workflow de GitHub Actions?

### Configuración del Workflow (ci.yml)

```yaml
name: CI - Continuous Integration

on:
  push:
    branches: [ main, master, develop ]
  pull_request:
    branches: [ main, master ]
```

**Se ejecuta cuando:**
- Haces `git push` a main, master, o develop
- Alguien crea un Pull Request

---

### Job 1: Test (Testing Multi-Versión)

**Ejecuta 5 jobs en paralelo:**

```
┌─────────────────────────────────────┐
│  Test on Python 3.9   │  ⚙️ Running  │
├─────────────────────────────────────┤
│  Test on Python 3.10  │  ⚙️ Running  │
├─────────────────────────────────────┤
│  Test on Python 3.11  │  ⚙️ Running  │
├─────────────────────────────────────┤
│  Test on Python 3.12  │  ⚙️ Running  │
├─────────────────────────────────────┤
│  Test on Python 3.13  │  ⚙️ Running  │
└─────────────────────────────────────┘
```

#### Pasos de cada job:

1. **Checkout code** (1s)
   ```yaml
   - uses: actions/checkout@v4
   ```
   → Descarga el código del repositorio

2. **Set up Python** (8s)
   ```yaml
   - uses: actions/setup-python@v5
     with:
       python-version: ${{ matrix.python-version }}
   ```
   → Instala la versión de Python especificada

3. **Display Python version** (1s)
   ```bash
   python -c "import sys; print(sys.version)"
   ```
   → Muestra la versión (para debugging)

4. **Install dependencies** (5s)
   ```bash
   python -m pip install --upgrade pip
   pip install pytest pytest-cov
   pip install -r requirements.txt
   ```
   → Instala las dependencias necesarias

5. **Run tests with pytest** (3s)
   ```bash
   pytest --cov=src --cov-report=term-missing --cov-report=xml -v
   ```
   → Ejecuta los tests y genera reporte de cobertura

6. **Upload coverage to Codecov** (1s)
   ```yaml
   - uses: codecov/codecov-action@v4
     if: matrix.python-version == '3.13'
   ```
   → Sube reporte de cobertura (solo Python 3.13)

---

### Job 2: Lint (Verificación de Calidad)

**Ejecuta en paralelo con los tests:**

```
┌─────────────────────────────────────┐
│  Code Quality Check   │  ⚙️ Running  │
└─────────────────────────────────────┘
```

#### Pasos:

1. **Checkout code**
2. **Set up Python 3.13**
3. **Install flake8**
4. **Lint with flake8**
   - Verifica errores de sintaxis
   - Verifica nombres indefinidos
   - Verifica estilo de código

---

## 📈 Resultado Visual Esperado

### Cuando todo pasa exitosamente:

```
✅ CI - Continuous Integration

  ✅ Test on Python 3.9 (23s)
     ✓ Set up job (2s)
     ✓ Checkout code (1s)
     ✓ Set up Python 3.9 (8s)
     ✓ Display Python version (1s)
     ✓ Install dependencies (5s)
     ✓ Run tests with pytest (3s)
        ======================== 3 passed in 0.15s ========================
        Coverage: 45%
     ✓ Complete job (1s)

  ✅ Test on Python 3.10 (21s)
  ✅ Test on Python 3.11 (22s)
  ✅ Test on Python 3.12 (20s)
  ✅ Test on Python 3.13 (24s)
  ✅ Code Quality Check (15s)

All checks have passed ✅
```

---

## 🔄 Flujo de Trabajo Completo

### 1. Desarrollo Local

```powershell
# Editar código
code src/calculator.py

# Ejecutar tests localmente
pytest -v

# Todo pasa ✅
```

### 2. Commit y Push

```powershell
git add .
git commit -m "Add multiply method"
git push origin main
```

### 3. GitHub Actions (Automático)

```
🚀 GitHub detecta el push
⚡ Trigger: push to main

⚙️  Inicia workflow "CI - Continuous Integration"
    
    🔄 Job: Test
       ├─ Python 3.9  → ⚙️ Running...
       ├─ Python 3.10 → ⚙️ Running...
       ├─ Python 3.11 → ⚙️ Running...
       ├─ Python 3.12 → ⚙️ Running...
       └─ Python 3.13 → ⚙️ Running...
    
    🔍 Job: Lint
       └─ Code Quality → ⚙️ Running...

⏳ Esperando resultados... (2-3 minutos)

✅ Todos los checks pasaron
📧 Notificación enviada (si está configurada)
```

### 4. Ver Resultados

```
🌐 GitHub Repository → Actions Tab
📊 Ver logs detallados
✅ Badge verde en README
```

---

## 📋 Pasos para Completar el Ejercicio

### Paso 1: Inicializar Git

```powershell
cd "d:\8th semester\CALIDAD DE SOFTWARE\PRACTICANDO TESTION 2\project"
git init
git config user.name "Tu Nombre"
git config user.email "tu_email@ejemplo.com"
```

### Paso 2: Hacer Primer Commit

```powershell
git add .
git commit -m "Initial commit: Calculator project with CI/CD"
```

### Paso 3: Crear Repositorio en GitHub

**Opción A: Manual (Web)**
1. Ve a https://github.com/new
2. Nombre: `calculator-testing-project`
3. Descripción: "Python calculator project with pytest, tox, and CI/CD"
4. Público o Privado (tú eliges)
5. NO agregues README, .gitignore, o licencia
6. Click "Create repository"

**Opción B: Con GitHub CLI**
```powershell
gh auth login
gh repo create calculator-testing-project --public --source=. --remote=origin
```

**Opción C: Usar el script de automatización**
```powershell
.\setup_git_github.ps1
```

### Paso 4: Conectar Repositorio Remoto

```powershell
git remote add origin https://github.com/TU_USUARIO/calculator-testing-project.git
git remote -v
```

### Paso 5: Subir Código a GitHub

```powershell
git branch -M main
git push -u origin main
```

**Primera vez:** GitHub te pedirá autenticación
- Usa tu usuario y un Personal Access Token como contraseña
- O usa GitHub CLI (`gh auth login`)

### Paso 6: Ver GitHub Actions

1. Ve a tu repositorio en GitHub
2. Click en la pestaña **"Actions"**
3. Verás el workflow ejecutándose
4. Click en el workflow para ver los detalles
5. Espera 2-3 minutos para que complete
6. ¡Verás checkmarks verdes ✅!

---

## 🎓 Conceptos Clave Aprendidos

### 1. **Continuous Integration (CI)**
- **Qué es:** Integración y testing automático del código
- **Por qué:** Detecta errores temprano, mantiene código funcional
- **Cómo:** GitHub Actions ejecuta tests en cada push

### 2. **GitHub Actions**
- **Workflows:** Archivos YAML que definen procesos automatizados
- **Jobs:** Tareas que se ejecutan en el workflow
- **Steps:** Pasos individuales dentro de un job
- **Matrix:** Ejecutar el mismo job con diferentes configuraciones
- **Triggers:** Eventos que inician el workflow (push, pull_request, etc.)

### 3. **YAML Syntax**
- **Indentación:** 2 espacios (muy importante)
- **Listas:** Prefijo con `-`
- **Diccionarios:** `key: value`
- **Variables:** `${{ variable }}`
- **Strings multilinea:** `|` o `>`

### 4. **Git & GitHub**
- **Git:** Sistema de control de versiones (local)
- **GitHub:** Plataforma cloud para repositorios
- **Remote:** Repositorio remoto (en GitHub)
- **Origin:** Nombre convencional del remote principal
- **Push:** Subir cambios locales a GitHub
- **Pull:** Descargar cambios de GitHub

---

## 🏆 Ventajas del CI/CD

### ✅ Detección Temprana de Errores
- Tests automáticos en cada cambio
- Múltiples versiones de Python probadas
- Feedback inmediato

### ✅ Calidad de Código Consistente
- Verificación automática de estilo
- Reportes de cobertura
- Standards mantenidos

### ✅ Ahorro de Tiempo
- No necesitas ejecutar tests manualmente
- Testing en paralelo (más rápido)
- Automatización completa

### ✅ Confianza en el Código
- Cada cambio es verificado
- Historial de tests
- Badge de estado visible

### ✅ Colaboración Mejorada
- Pull Requests con CI automático
- Code reviews con contexto
- Merge solo cuando tests pasan

---

## 📊 Badges para README

Agrega estos badges al inicio de tu README:

```markdown
![CI](https://github.com/TU_USUARIO/calculator-testing-project/workflows/CI%20-%20Continuous%20Integration/badge.svg)
![Python](https://img.shields.io/badge/python-3.9%20%7C%203.10%20%7C%203.11%20%7C%203.12%20%7C%203.13-blue)
![pytest](https://img.shields.io/badge/tests-passing-brightgreen)
![Coverage](https://img.shields.io/badge/coverage-45%25-yellow)
```

**Resultado visual:**
- ![CI](https://img.shields.io/badge/CI-passing-brightgreen)
- ![Python](https://img.shields.io/badge/python-3.9%20%7C%203.10%20%7C%203.11%20%7C%203.12%20%7C%203.13-blue)
- ![pytest](https://img.shields.io/badge/tests-passing-brightgreen)
- ![Coverage](https://img.shields.io/badge/coverage-45%25-yellow)

---

## 🛠️ Mejoras Opcionales

### 1. Agregar Testing en Windows y macOS

```yaml
strategy:
  matrix:
    os: [ubuntu-latest, windows-latest, macos-latest]
    python-version: ['3.9', '3.10', '3.11', '3.12', '3.13']
runs-on: ${{ matrix.os }}
```

### 2. Agregar Cache para Dependencias

```yaml
- name: Cache pip packages
  uses: actions/cache@v3
  with:
    path: ~/.cache/pip
    key: ${{ runner.os }}-pip-${{ hashFiles('**/requirements.txt') }}
```

### 3. Agregar Codecov Integration

1. Registrarse en https://codecov.io/
2. Conectar tu repositorio
3. Copiar el token
4. Agregarlo como secret en GitHub (Settings → Secrets → CODECOV_TOKEN)

### 4. Agregar Deploy Automático

```yaml
deploy:
  needs: test
  runs-on: ubuntu-latest
  if: github.ref == 'refs/heads/main'
  steps:
    - name: Deploy to production
      run: echo "Deploying..."
```

---

## 🚨 Solución de Problemas

### Problema: Workflow no se ejecuta

**Verificar:**
1. ¿El archivo está en `.github/workflows/ci.yml`?
2. ¿Es YAML válido? (indentación correcta)
3. ¿Hiciste push a la rama correcta?
4. ¿GitHub Actions está habilitado?
   - Settings → Actions → Allow all actions

### Problema: Tests fallan en GitHub pero pasan localmente

**Posibles causas:**
1. Dependencias faltantes en requirements.txt
2. Rutas absolutas en lugar de relativas
3. Variables de entorno no configuradas
4. Diferencias entre Windows y Linux

### Problema: "authentication failed"

**Solución:**
```powershell
# Opción 1: GitHub CLI
gh auth login

# Opción 2: Personal Access Token
# Crear en: https://github.com/settings/tokens
# Usar como contraseña cuando Git lo pida
```

---

## 📝 Checklist Final

```
✅ Directorio .github/workflows/ creado
✅ Archivo ci.yml creado y configurado
✅ .gitignore configurado
✅ requirements.txt existe
✅ README.md actualizado con badges
✅ Script de automatización creado (setup_git_github.ps1)
✅ Documentación completa creada (GITHUB_ACTIONS_SETUP.md)
⬜ Repositorio Git local inicializado
⬜ Repositorio GitHub creado
⬜ Código subido a GitHub
⬜ Workflow ejecutándose en GitHub Actions
⬜ Tests pasando en todas las versiones
⬜ Badge de CI funcionando
```

---

## 🎯 Meta del Ejercicio

> **"Hacer un git push a tu repositorio y ver en la pestaña 'Actions' de GitHub cómo tu workflow se ejecuta y los tests pasan exitosamente en la nube."**

### Para Lograr la Meta:

1. ✅ **Configuración completada** → Ya está lista
2. ⏳ **Crear repositorio GitHub** → Sigue Paso 3
3. ⏳ **Subir código** → Sigue Paso 5
4. ⏳ **Ver Actions** → Sigue Paso 6

---

## 🔗 Enlaces Útiles

- **GitHub Actions Docs:** https://docs.github.com/en/actions
- **Workflow Syntax:** https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions
- **actions/checkout:** https://github.com/actions/checkout
- **actions/setup-python:** https://github.com/actions/setup-python
- **GitHub CLI:** https://cli.github.com/
- **Personal Access Tokens:** https://github.com/settings/tokens

---

## 🎉 ¡Siguiente Paso!

**Ejecuta el script de configuración:**

```powershell
cd "d:\8th semester\CALIDAD DE SOFTWARE\PRACTICANDO TESTION 2\project"
.\setup_git_github.ps1
```

O **sigue la guía manual** en `GITHUB_ACTIONS_SETUP.md`

---

**¡Estás a solo unos comandos de tener tu pipeline de CI/CD funcionando en la nube!** 🚀

---

**Fecha:** Noviembre 1, 2025  
**Estado:** ✅ CONFIGURACIÓN COMPLETADA  
**Pendiente:** Subir a GitHub y ver el workflow ejecutándose  
