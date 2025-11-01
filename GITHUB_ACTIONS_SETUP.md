# 🚀 Ejercicio 7: Configurando GitHub Actions CI/CD Pipeline

## ✅ Archivos Creados

```
project/
├── .github/
│   └── workflows/
│       └── ci.yml          ✅ CREADO - Workflow de GitHub Actions
├── .gitignore              ✅ CREADO - Ignorar archivos innecesarios
├── requirements.txt        ✅ EXISTE - Dependencias del proyecto
├── src/
├── tests/
└── ...
```

---

## 📋 Guía Paso a Paso para Configurar GitHub Actions

### Paso 1: Inicializar Repositorio Git Local

Abre PowerShell en el directorio del proyecto y ejecuta:

```powershell
cd "d:\8th semester\CALIDAD DE SOFTWARE\PRACTICANDO TESTION 2\project"

# Inicializar repositorio Git
git init

# Ver estado actual
git status
```

**Salida esperada:**
```
Initialized empty Git repository in D:/8th semester/CALIDAD DE SOFTWARE/PRACTICANDO TESTION 2/project/.git/
```

---

### Paso 2: Configurar Git (Si es la primera vez)

```powershell
# Configurar tu nombre y email (si no lo has hecho antes)
git config --global user.name "Tu Nombre"
git config --global user.email "tu_email@ejemplo.com"

# Verificar configuración
git config --global user.name
git config --global user.email
```

---

### Paso 3: Agregar Archivos al Repositorio

```powershell
# Agregar todos los archivos al staging area
git add .

# Ver qué archivos se agregarán
git status

# Hacer el primer commit
git commit -m "Initial commit: Calculator project with tests and CI/CD setup"
```

**Salida esperada:**
```
[master (root-commit) abc1234] Initial commit: Calculator project with tests and CI/CD setup
 XX files changed, XXX insertions(+)
 create mode 100644 .github/workflows/ci.yml
 create mode 100644 .gitignore
 create mode 100644 README.md
 create mode 100644 requirements.txt
 create mode 100644 src/calculator.py
 create mode 100644 tests/test_calculator.py
 ...
```

---

### Paso 4: Crear Repositorio en GitHub

#### Opción A: Desde la Web de GitHub

1. **Ve a GitHub:** https://github.com/
2. **Inicia sesión** con tu cuenta
3. **Click en el botón "+" arriba a la derecha** → "New repository"
4. **Configura el repositorio:**
   - **Repository name:** `calculator-testing-project` (o el nombre que prefieras)
   - **Description:** "Python calculator project with pytest, tox, and CI/CD"
   - **Visibilidad:** Public o Private (tú eliges)
   - **NO marques** "Add a README file" (ya tienes uno)
   - **NO marques** "Add .gitignore" (ya tienes uno)
   - **NO marques** "Choose a license" (puedes agregarlo después)
5. **Click en "Create repository"**

#### Opción B: Desde la Terminal con GitHub CLI (gh)

Si tienes GitHub CLI instalado:

```powershell
# Crear repositorio directamente desde la terminal
gh repo create calculator-testing-project --public --source=. --remote=origin --push
```

---

### Paso 5: Conectar Repositorio Local con GitHub

Después de crear el repositorio en GitHub, verás instrucciones. Ejecuta:

```powershell
# Agregar el repositorio remoto
git remote add origin https://github.com/TU_USUARIO/calculator-testing-project.git

# Verificar que se agregó correctamente
git remote -v
```

**Salida esperada:**
```
origin  https://github.com/TU_USUARIO/calculator-testing-project.git (fetch)
origin  https://github.com/TU_USUARIO/calculator-testing-project.git (push)
```

---

### Paso 6: Subir el Código a GitHub

```powershell
# Renombrar la rama principal a 'main' (si es necesario)
git branch -M main

# Hacer push del código
git push -u origin main
```

**Nota:** La primera vez que hagas push, GitHub te pedirá autenticación:
- **Opción 1:** Usar un Personal Access Token (recomendado)
- **Opción 2:** Usar GitHub CLI para autenticación automática

#### Crear un Personal Access Token (si es necesario):

1. Ve a: https://github.com/settings/tokens
2. Click en "Generate new token" → "Generate new token (classic)"
3. Nombre: "Calculator Project CI/CD"
4. Selecciona scopes:
   - ✅ `repo` (Full control of private repositories)
   - ✅ `workflow` (Update GitHub Action workflows)
5. Click "Generate token"
6. **COPIA EL TOKEN** (no podrás verlo de nuevo)
7. Úsalo como contraseña cuando Git te pida credenciales

---

### Paso 7: Verificar GitHub Actions

1. **Ve a tu repositorio en GitHub**
   - URL: `https://github.com/TU_USUARIO/calculator-testing-project`

2. **Click en la pestaña "Actions"**

3. **Deberías ver tu workflow ejecutándose:**
   ```
   ⚙️ CI - Continuous Integration
   Running...
   ```

4. **Click en el workflow** para ver los detalles:
   - Test on Python 3.9
   - Test on Python 3.10
   - Test on Python 3.11
   - Test on Python 3.12
   - Test on Python 3.13
   - Code Quality Check (lint)

5. **Espera a que termine** (puede tomar 2-5 minutos)

6. **Verás checkmarks verdes ✅** cuando todo pase exitosamente

---

## 📊 ¿Qué Hace el Workflow de GitHub Actions?

### Triggers (Cuándo se ejecuta)

```yaml
on:
  push:
    branches: [ main, master, develop ]
  pull_request:
    branches: [ main, master ]
```

**Se ejecuta cuando:**
- Haces `git push` a las ramas main, master, o develop
- Alguien crea un Pull Request hacia main o master

---

### Job 1: Test (Testing Multi-Versión)

```yaml
strategy:
  matrix:
    python-version: ['3.9', '3.10', '3.11', '3.12', '3.13']
```

**Ejecuta 5 jobs en paralelo**, uno por cada versión de Python:

#### Pasos del Job:

1. **Checkout code** → Descarga tu código del repositorio
2. **Set up Python** → Instala la versión de Python especificada
3. **Display Python version** → Muestra la versión (para debugging)
4. **Install dependencies** → Instala pytest, pytest-cov, y requirements.txt
5. **Run tests** → Ejecuta `pytest --cov=src --cov-report=term-missing -v`
6. **Upload coverage** → Sube reporte de cobertura (opcional)

---

### Job 2: Lint (Verificación de Calidad de Código)

**Ejecuta flake8** para verificar:
- Errores de sintaxis
- Nombres indefinidos
- Imports no usados
- Estilo de código

---

## 🎯 Verificación Visual en GitHub Actions

### Vista de Workflow Exitoso:

```
✅ CI - Continuous Integration
    ✅ Test on Python 3.9 (23s)
    ✅ Test on Python 3.10 (21s)
    ✅ Test on Python 3.11 (22s)
    ✅ Test on Python 3.12 (20s)
    ✅ Test on Python 3.13 (24s)
    ✅ Code Quality Check (15s)

All checks have passed
```

### Vista de un Job Individual:

```
✅ Test on Python 3.12

  ✅ Set up job (2s)
  ✅ Checkout code (1s)
  ✅ Set up Python 3.12 (8s)
  ✅ Display Python version (1s)
  ✅ Install dependencies (5s)
  ✅ Run tests with pytest (3s)
     ======================== 3 passed in 0.15s ========================
     Coverage: 45%
  ✅ Upload coverage to Codecov (1s)
  ✅ Complete job (1s)
```

---

## 🔄 Flujo de Trabajo Completo

### 1. Desarrollo Local

```powershell
# Trabajas en tu código
code src/calculator.py

# Ejecutas tests localmente
pytest

# Todo pasa ✅
```

### 2. Commit y Push

```powershell
# Agregar cambios
git add .

# Commit
git commit -m "Add new feature: multiply method"

# Push a GitHub
git push origin main
```

### 3. GitHub Actions Automático

```
🚀 GitHub detecta el push
⚙️  Inicia el workflow automáticamente
🔄 Ejecuta tests en 5 versiones de Python en paralelo
🔍 Ejecuta verificación de calidad de código
✅ Todo pasa → Badge verde
❌ Algo falla → Recibes notificación por email
```

### 4. Ver Resultados

```
📧 Recibes email si algo falla
🌐 Ves resultados en GitHub → Actions tab
📊 Badge de estado en tu README
```

---

## 📈 Agregar Badge de Estado al README

Agrega esto al inicio de tu `README.md`:

```markdown
# Calculator Testing Project

![CI](https://github.com/TU_USUARIO/calculator-testing-project/workflows/CI%20-%20Continuous%20Integration/badge.svg)
![Python](https://img.shields.io/badge/python-3.9%20%7C%203.10%20%7C%203.11%20%7C%203.12%20%7C%203.13-blue)
![pytest](https://img.shields.io/badge/tests-passing-brightgreen)
![Coverage](https://img.shields.io/badge/coverage-45%25-yellow)
```

**Resultado visual:**
- ![CI](https://img.shields.io/badge/CI-passing-brightgreen)
- ![Python](https://img.shields.io/badge/python-3.9%20%7C%203.10%20%7C%203.11%20%7C%203.12%20%7C%203.13-blue)

---

## 🛠️ Comandos Git Útiles

```powershell
# Ver estado del repositorio
git status

# Ver historial de commits
git log --oneline

# Ver diferencias antes de commit
git diff

# Ver ramas
git branch

# Crear nueva rama
git checkout -b feature/nueva-funcionalidad

# Cambiar de rama
git checkout main

# Actualizar desde GitHub
git pull origin main

# Ver qué archivos están en staging
git status

# Deshacer cambios no commiteados
git checkout -- archivo.py

# Ver commits remotos
git log origin/main

# Ver configuración de Git
git config --list
```

---

## 🎓 Conceptos Aprendidos

### 1. **Continuous Integration (CI)**
- **Qué es:** Integración automática y testing del código
- **Beneficios:** Detecta errores temprano, código siempre funcional
- **Cómo:** GitHub Actions ejecuta tests automáticamente en cada push

### 2. **GitHub Actions**
- **Workflows:** Archivos YAML que definen procesos automatizados
- **Jobs:** Tareas individuales que se ejecutan en el workflow
- **Steps:** Pasos específicos dentro de un job
- **Matrix:** Ejecutar el mismo job con diferentes configuraciones

### 3. **Git & GitHub**
- **Git:** Sistema de control de versiones (local)
- **GitHub:** Plataforma en la nube para alojar repositorios
- **Push:** Subir cambios locales a GitHub
- **Pull:** Descargar cambios de GitHub a local

### 4. **YAML Syntax**
- **Formato:** Indentación con espacios (2 o 4)
- **Listas:** Prefijo con `-`
- **Diccionarios:** `key: value`
- **Variables:** `${{ variable }}`

---

## 🚨 Solución de Problemas Comunes

### Problema 1: "authentication failed"

**Solución:**
```powershell
# Usar GitHub CLI para autenticación
gh auth login

# O usar Personal Access Token como contraseña
# (Ver Paso 6 para crear el token)
```

---

### Problema 2: Workflow no se ejecuta

**Verificaciones:**
1. ¿El archivo está en `.github/workflows/ci.yml`?
2. ¿Es un archivo YAML válido? (indentación correcta)
3. ¿Hiciste push a la rama correcta (main)?
4. ¿GitHub Actions está habilitado en tu repositorio?
   - Settings → Actions → Allow all actions

---

### Problema 3: Tests fallan en GitHub pero pasan localmente

**Posibles causas:**
1. **Dependencias faltantes:** Verifica `requirements.txt`
2. **Rutas absolutas:** Usa rutas relativas en los tests
3. **Variables de entorno:** Configura en el workflow
4. **Sistema operativo:** Considera diferencias Linux vs Windows

**Solución:**
```yaml
# Agregar variables de entorno en ci.yml
env:
  PYTHONPATH: ${{ github.workspace }}/src
```

---

### Problema 4: "refusing to merge unrelated histories"

**Solución:**
```powershell
git pull origin main --allow-unrelated-histories
```

---

## 📊 Mejoras Opcionales del Workflow

### 1. Agregar Cache para Dependencias

```yaml
- name: Cache pip packages
  uses: actions/cache@v3
  with:
    path: ~/.cache/pip
    key: ${{ runner.os }}-pip-${{ hashFiles('**/requirements.txt') }}
    restore-keys: |
      ${{ runner.os }}-pip-
```

**Beneficio:** Instala dependencias más rápido (de 30s a 5s)

---

### 2. Ejecutar en Múltiples Sistemas Operativos

```yaml
strategy:
  matrix:
    os: [ubuntu-latest, windows-latest, macos-latest]
    python-version: ['3.9', '3.10', '3.11', '3.12', '3.13']
runs-on: ${{ matrix.os }}
```

**Beneficio:** Asegura compatibilidad cross-platform

---

### 3. Agregar Codecov para Tracking de Cobertura

```yaml
- name: Upload coverage to Codecov
  uses: codecov/codecov-action@v4
  with:
    file: ./coverage.xml
    token: ${{ secrets.CODECOV_TOKEN }}
```

**Beneficio:** Visualiza evolución de la cobertura de código

---

### 4. Deploy Automático (cuando los tests pasen)

```yaml
deploy:
  needs: test
  runs-on: ubuntu-latest
  if: github.ref == 'refs/heads/main'
  steps:
    - name: Deploy to production
      run: |
        echo "Deploying to production..."
```

---

## 🎯 Checklist de Completado

```
✅ Directorio .github/workflows/ creado
✅ Archivo ci.yml creado con configuración completa
✅ .gitignore configurado
✅ requirements.txt existe
✅ Repositorio Git local inicializado
⬜ Repositorio GitHub creado
⬜ Código subido a GitHub (git push)
⬜ Workflow ejecutándose en GitHub Actions
⬜ Tests pasando en todas las versiones de Python
⬜ Badge de CI agregado al README
```

---

## 📝 Comandos de Resumen para Completar el Ejercicio

```powershell
# 1. Inicializar Git
cd "d:\8th semester\CALIDAD DE SOFTWARE\PRACTICANDO TESTION 2\project"
git init
git config user.name "Tu Nombre"
git config user.email "tu_email@ejemplo.com"

# 2. Hacer primer commit
git add .
git commit -m "Initial commit: Calculator project with CI/CD"

# 3. Crear repositorio en GitHub (hacerlo en la web)
# https://github.com/new

# 4. Conectar y subir
git remote add origin https://github.com/TU_USUARIO/calculator-testing-project.git
git branch -M main
git push -u origin main

# 5. Ver en GitHub Actions
# https://github.com/TU_USUARIO/calculator-testing-project/actions
```

---

## 🎉 Meta Alcanzada

Cuando completes todos los pasos, habrás logrado:

✅ **Repositorio en GitHub** con tu código

✅ **Workflow de CI/CD** ejecutándose automáticamente

✅ **Tests corriendo** en 5 versiones de Python en la nube

✅ **Verificación de calidad** de código automática

✅ **Feedback instantáneo** en cada cambio de código

✅ **Badge de estado** mostrando la salud del proyecto

---

## 🔗 Referencias Útiles

- **GitHub Actions Docs:** https://docs.github.com/en/actions
- **Workflow Syntax:** https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions
- **GitHub CLI:** https://cli.github.com/
- **Personal Access Tokens:** https://github.com/settings/tokens
- **Git Basics:** https://git-scm.com/book/en/v2/Getting-Started-Git-Basics
- **YAML Syntax:** https://yaml.org/spec/1.2/spec.html

---

**¡Ahora estás listo para configurar tu pipeline de CI/CD con GitHub Actions!** 🚀

Sigue los pasos en orden y verás tus tests ejecutándose automáticamente en la nube.
