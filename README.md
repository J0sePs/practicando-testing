# 🚀 Ejercicio 7: Configurando GitHub Actions CI/CD Pipeline con Codecov

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

## 📋 Guía COMPLETA Paso a Paso para Configurar GitHub Actions + Codecov

### Paso 0: Instalar Extensión de GitHub Actions en VS Code (IMPORTANTE)

Antes de empezar, instala la extensión de GitHub Actions en VS Code para tener mejor soporte de sintaxis:

1. **Abre VS Code**
2. **Ve a Extensiones** (Ctrl+Shift+X)
3. **Busca:** `GitHub Actions`
4. **Instala la extensión oficial de GitHub** (Publisher: GitHub)

**Beneficio:** Validación de sintaxis YAML, autocompletado, y detección de errores en tu archivo `ci.yml`

---

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

### Paso 7: Configurar Codecov para Reportes de Cobertura

Codecov es un servicio que te muestra gráficamente la cobertura de tus tests.

#### 7.1. Crear Cuenta en Codecov

1. **Ve a:** https://codecov.io
2. **Click en "Sign up"**
3. **Selecciona "Sign up with GitHub"**
4. **Autoriza a Codecov** para acceder a tu cuenta de GitHub
5. **Completa el registro:**
   - **Nombre:** Tu nombre o username de GitHub
   - **Email:** Usa el **mismo email de tu cuenta de GitHub**
   - **Marca las casillas:**
     - ☐ Recibir actualizaciones (opcional)
     - ☑️ Acepto términos de servicio y política de privacidad (obligatorio)
6. **Click en "Continue"**

#### 7.2. Agregar tu Repositorio a Codecov

1. **Una vez dentro de Codecov**, haz click en **"Add new repository"**
2. **Busca tu repositorio** en la lista: `practicando-testing` o el nombre que usaste
3. **Activa la integración** haciendo click en **"Setup repo"**
4. **Codecov te mostrará un token** como este:
   ```
   ccf0e981-a9a3-4951-9fc0-45d8f67d89b4
   ```
5. **COPIA este token** (lo necesitarás en el siguiente paso)

#### 7.3. Agregar el Token de Codecov como Secreto en GitHub

1. **Ve a tu repositorio en GitHub:**
   - URL: `https://github.com/TU_USUARIO/practicando-testing`
2. **Click en "Settings"** (Configuración)
3. **En el menú lateral izquierdo:**
   - Click en **"Secrets and variables"** → **"Actions"**
4. **Click en el botón verde "New repository secret"**
5. **Configurar el secreto:**
   - **Name:** `CODECOV_TOKEN` (exactamente así, en mayúsculas)
   - **Secret:** Pega el token que copiaste de Codecov
6. **Click en "Add secret"**

#### 7.4. Verificar que el Archivo ci.yml está Correcto

Tu archivo `.github/workflows/ci.yml` debe tener esta sección (ya debería estar):

```yaml
- name: Upload coverage to Codecov
  uses: codecov/codecov-action@v4
  if: matrix.python-version == '3.13'
  with:
    file: ./coverage.xml
    fail_ci_if_error: false
    token: ${{ secrets.CODECOV_TOKEN }}
```

**Nota:** La línea `token: ${{ secrets.CODECOV_TOKEN }}` hace referencia al secreto que acabas de crear.

#### 7.5. Hacer Push para Activar el Workflow con Codecov

```powershell
# Si hiciste cambios, guárdalos
git add .
git commit -m "Configurar Codecov para reportes de cobertura"
git push origin main
```

---

### Paso 8: Verificar GitHub Actions y Codecov

#### 8.1. Ver GitHub Actions

1. **Ve a tu repositorio en GitHub**
   - URL: `https://github.com/TU_USUARIO/practicando-testing`

2. **Click en la pestaña "Actions"**

3. **Deberías ver tu workflow ejecutándose:**
   ```
   ⚙️ CI - Continuous Integration
   Running...
   ```

4. **Click en el workflow** para ver los detalles:
   - ✅ Test on Python 3.9
   - ✅ Test on Python 3.10
   - ✅ Test on Python 3.11
   - ✅ Test on Python 3.12
   - ✅ Test on Python 3.13
   - ✅ Code Quality Check (lint)

5. **Espera a que termine** (puede tomar 2-5 minutos)

6. **Verás checkmarks verdes ✅** cuando todo pase exitosamente

#### 8.2. Ver Reporte de Cobertura en Codecov

1. **Ve a Codecov:** https://codecov.io
2. **Busca tu repositorio** en el dashboard
3. **Click en el repositorio** para ver:
   - **Porcentaje de cobertura** (Coverage %)
   - **Archivos cubiertos** (Files)
   - **Líneas cubiertas/totales** (Lines)
   - **Gráficas de evolución** (Trend)
4. **Explora el reporte:**
   - Click en archivos para ver líneas cubiertas/no cubiertas
   - Líneas verdes = cubiertas por tests
   - Líneas rojas = NO cubiertas por tests

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

## 📈 Agregar Badges de Estado al README

Agrega esto al inicio de tu `README.md`:

```markdown
# Calculator Testing Project

![CI](https://github.com/TU_USUARIO/practicando-testing/workflows/CI%20-%20Continuous%20Integration/badge.svg)
![Python](https://img.shields.io/badge/python-3.9%20%7C%203.10%20%7C%203.11%20%7C%203.12%20%7C%203.13-blue)
![pytest](https://img.shields.io/badge/tests-passing-brightgreen)
[![codecov](https://codecov.io/gh/TU_USUARIO/practicando-testing/branch/main/graph/badge.svg)](https://codecov.io/gh/TU_USUARIO/practicando-testing)
```

**Reemplaza `TU_USUARIO`** con tu username de GitHub.

**Resultado visual:**
- ![CI](https://img.shields.io/badge/CI-passing-brightgreen) ← Estado del CI
- ![Python](https://img.shields.io/badge/python-3.9%20%7C%203.10%20%7C%203.11%20%7C%203.12%20%7C%203.13-blue) ← Versiones soportadas
- ![codecov](https://img.shields.io/badge/coverage-85%25-brightgreen) ← Cobertura de código

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

### Problema 1: "authentication failed" al hacer git push

**Solución:**
```powershell
# Usar GitHub CLI para autenticación
gh auth login

# O usar Personal Access Token como contraseña
# (Ver Paso 6 para crear el token)
```

---

### Problema 2: Errores de sintaxis en ci.yml

**Síntomas:**
- Advertencias rojas en VS Code
- Workflow no aparece en GitHub Actions
- Errores como: `'name' is already defined`, `'on' is already defined`, `'jobs' is already defined`

**Causa:** El archivo `ci.yml` tiene contenido duplicado

**Solución:**
1. **Instala la extensión GitHub Actions en VS Code** (si no la tienes)
2. Abre el archivo `ci.yml`
3. **Busca secciones duplicadas** (name, on, jobs definidos dos veces)
4. **Elimina el contenido duplicado** (deja solo una copia de cada sección)
5. Verifica que no haya errores en VS Code

---

### Problema 3: Workflow no se ejecuta

**Verificaciones:**
1. ¿El archivo está en `.github/workflows/ci.yml`?
2. ¿Es un archivo YAML válido? (indentación correcta)
3. ¿Hiciste push a la rama correcta (main)?
4. ¿GitHub Actions está habilitado en tu repositorio?
   - Settings → Actions → Allow all actions

---

### Problema 4: Tests fallan en GitHub pero pasan localmente

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

### Problema 5: "refusing to merge unrelated histories"

**Solución:**
```powershell
git pull origin main --allow-unrelated-histories
```

---

### Problema 6: Advertencia "Context access might be invalid: CODECOV_TOKEN"

**Síntomas:**
- Advertencia amarilla en la línea `token: ${{ secrets.CODECOV_TOKEN }}`

**Es Normal:**
- Esta advertencia solo indica que el secreto `CODECOV_TOKEN` debe estar configurado en GitHub
- Si ya agregaste el secreto en GitHub (Paso 7.3), puedes **ignorar esta advertencia**
- El workflow funcionará correctamente cuando se ejecute en GitHub

**No es un error**, es solo una advertencia informativa de VS Code.

---

### Problema 7: No aparece el token en Codecov

**Solución:**
1. Asegúrate de haber **autorizado a Codecov** con tu cuenta de GitHub
2. **Refresca la página** de Codecov
3. **Agrega el repositorio manualmente:**
   - Dashboard → Add new repository → Busca tu repo
4. El token aparecerá en la página de configuración del repositorio

---

### Problema 8: El workflow se ejecuta pero no sube cobertura a Codecov

**Verificaciones:**
1. ¿Agregaste el secreto `CODECOV_TOKEN` en GitHub?
   - Settings → Secrets and variables → Actions → CODECOV_TOKEN
2. ¿El nombre del secreto es exactamente `CODECOV_TOKEN`? (mayúsculas)
3. ¿El token es correcto? (copia nuevamente desde Codecov si es necesario)
4. Revisa los logs del workflow en GitHub Actions:
   - Tab Actions → Click en el workflow → Click en "Upload coverage to Codecov"

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

### Pre-requisitos
```
✅ Extensión de GitHub Actions instalada en VS Code
✅ Cuenta de GitHub creada
✅ Git configurado (user.name y user.email)
```

### Configuración Local
```
✅ Directorio .github/workflows/ creado
✅ Archivo ci.yml creado con configuración completa
✅ .gitignore configurado
✅ requirements.txt existe
✅ Repositorio Git local inicializado
```

### Configuración GitHub
```
⬜ Repositorio GitHub creado
⬜ Código subido a GitHub (git push)
⬜ Workflow ejecutándose en GitHub Actions
⬜ Tests pasando en todas las versiones de Python
```

### Configuración Codecov
```
⬜ Cuenta de Codecov creada (con GitHub)
⬜ Repositorio agregado en Codecov
⬜ Token CODECOV_TOKEN copiado
⬜ Secreto CODECOV_TOKEN agregado en GitHub
⬜ Workflow ejecutado con Codecov
⬜ Reporte de cobertura visible en Codecov
```

### Extras
```
⬜ Badges de CI y Codecov agregados al README
⬜ README actualizado con documentación
```

---

## 📝 Comandos de Resumen para Completar el Ejercicio

### Comandos Git (Terminal)

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
git remote add origin https://github.com/TU_USUARIO/practicando-testing.git
git branch -M main
git push -u origin main

# 5. Ver en GitHub Actions
# https://github.com/TU_USUARIO/practicando-testing/actions
```

### Pasos en la Web

```
1. ✅ Instalar extensión GitHub Actions en VS Code
   → Extensions (Ctrl+Shift+X)
   → Buscar: "GitHub Actions"
   → Instalar (Publisher: GitHub)

2. ✅ Crear cuenta en Codecov
   → https://codecov.io
   → Sign up with GitHub
   → Completar registro con email de GitHub

3. ✅ Configurar repositorio en Codecov
   → Dashboard → Add new repository
   → Buscar: practicando-testing
   → Setup repo → Copiar token

4. ✅ Agregar secreto en GitHub
   → GitHub → Tu repo → Settings
   → Secrets and variables → Actions
   → New repository secret
   → Name: CODECOV_TOKEN
   → Secret: [pegar token de Codecov]
   → Add secret

5. ✅ Verificar workflow
   → GitHub → Tu repo → Actions
   → Ver workflow ejecutándose
   → Esperar checkmarks verdes ✅

6. ✅ Ver cobertura en Codecov
   → https://codecov.io
   → Dashboard → Tu repo
   → Ver porcentaje y archivos
```

---

## 🎉 Meta Alcanzada

Cuando completes todos los pasos, habrás logrado:

✅ **Extensión GitHub Actions instalada** en VS Code

✅ **Repositorio en GitHub** con tu código

✅ **Workflow de CI/CD** ejecutándose automáticamente

✅ **Tests corriendo** en 5 versiones de Python en paralelo en la nube

✅ **Verificación de calidad** de código automática (flake8)

✅ **Cobertura de código** visualizada en Codecov

✅ **Token de Codecov configurado** como secreto en GitHub

✅ **Feedback instantáneo** en cada cambio de código

✅ **Badges de estado** mostrando la salud del proyecto (CI + Coverage)

✅ **Documentación completa** en README para futuras referencias

---

## 🎓 Lecciones Aprendidas

### Errores Comunes y Sus Soluciones

1. **No instalar la extensión de GitHub Actions en VS Code**
   - **Problema:** No se detectan errores de sintaxis YAML
   - **Solución:** Instalar extensión antes de empezar

2. **Contenido duplicado en ci.yml**
   - **Problema:** Advertencias "name/on/jobs already defined"
   - **Solución:** Eliminar contenido duplicado del archivo

3. **No crear cuenta en Codecov primero**
   - **Problema:** No se puede obtener el token
   - **Solución:** Crear cuenta en Codecov.io con GitHub

4. **Usar email diferente en Codecov y GitHub**
   - **Problema:** Las cuentas no se vinculan correctamente
   - **Solución:** Usar el mismo email en ambas plataformas

5. **No agregar el secreto CODECOV_TOKEN en GitHub**
   - **Problema:** El workflow falla al subir cobertura
   - **Solución:** Settings → Secrets → Agregar CODECOV_TOKEN

6. **Nombre incorrecto del secreto**
   - **Problema:** GitHub no encuentra el token
   - **Solución:** Nombre exacto en mayúsculas: `CODECOV_TOKEN`

---

## 🔗 Referencias Útiles

### Documentación Oficial
- **GitHub Actions Docs:** https://docs.github.com/en/actions
- **Workflow Syntax:** https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions
- **Codecov Docs:** https://docs.codecov.com/docs
- **GitHub CLI:** https://cli.github.com/
- **Personal Access Tokens:** https://github.com/settings/tokens
- **Git Basics:** https://git-scm.com/book/en/v2/Getting-Started-Git-Basics
- **YAML Syntax:** https://yaml.org/spec/1.2/spec.html

### Extensiones de VS Code Recomendadas
- **GitHub Actions** (by GitHub) - Soporte para workflows
- **YAML** (by Red Hat) - Validación y autocompletado YAML
- **GitLens** (by GitKraken) - Visualización avanzada de Git
- **Python** (by Microsoft) - Soporte completo para Python

### Herramientas Online
- **GitHub:** https://github.com
- **Codecov:** https://codecov.io
- **GitHub Actions Marketplace:** https://github.com/marketplace?type=actions

---

## 📊 Resumen Visual del Flujo Completo

```
┌─────────────────────────────────────────────────────────────────┐
│ 1. DESARROLLO LOCAL (VS Code)                                  │
│    ✓ Extensión GitHub Actions instalada                        │
│    ✓ Código Python + Tests                                     │
│    ✓ Archivo .github/workflows/ci.yml                          │
└────────────────────────┬────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────────┐
│ 2. GIT LOCAL                                                    │
│    git init → git add . → git commit                           │
└────────────────────────┬────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────────┐
│ 3. GITHUB (Repositorio Remoto)                                 │
│    git remote add origin → git push                            │
│    ✓ Código subido                                             │
│    ✓ Actions habilitado                                        │
└────────────────────────┬────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────────┐
│ 4. CODECOV (Servicio de Cobertura)                             │
│    ✓ Cuenta creada con GitHub                                  │
│    ✓ Repositorio agregado                                      │
│    ✓ Token obtenido                                            │
└────────────────────────┬────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────────┐
│ 5. GITHUB SECRETS                                               │
│    Settings → Secrets → CODECOV_TOKEN                          │
└────────────────────────┬────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────────┐
│ 6. GITHUB ACTIONS (Automático en cada push)                    │
│    ┌──────────────────────────────────────────┐                │
│    │ ✓ Test Python 3.9  (parallel)           │                │
│    │ ✓ Test Python 3.10 (parallel)           │                │
│    │ ✓ Test Python 3.11 (parallel)           │                │
│    │ ✓ Test Python 3.12 (parallel)           │                │
│    │ ✓ Test Python 3.13 (parallel)           │                │
│    │ ✓ Code Quality Check                    │                │
│    │ ✓ Upload to Codecov                     │                │
│    └──────────────────────────────────────────┘                │
└────────────────────────┬────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────────┐
│ 7. RESULTADOS                                                   │
│    ✓ Badge verde en GitHub                                     │
│    ✓ Reporte de cobertura en Codecov                           │
│    ✓ Notificaciones por email si falla                         │
│    ✓ Comentarios automáticos en Pull Requests                  │
└─────────────────────────────────────────────────────────────────┘
```

---

**¡Ahora tienes una guía completa y sin errores para configurar tu pipeline de CI/CD con GitHub Actions y Codecov!** 🚀

Sigue los pasos en orden y verás tus tests ejecutándose automáticamente en la nube con reportes de cobertura profesionales.

---

# 🐛 Ejercicio 8: Depurando Test Failures (Parte 1: Verbose y --showlocals)

## 🎯 Objetivo

Utilizar las opciones de pytest para obtener más información cuando un test falla, facilitando el debugging y la identificación de problemas.

---

## 📝 Tarea Realizada

### 1. Crear un Test que Falla Intencionalmente

Se agregó el test `test_division` en `tests/test_calculator.py` que falla a propósito:

```python
def test_division():
    """
    Test the division operation that fails on purpose.
    
    Ejercicio 8: Este test falla intencionalmente para demostrar
    las opciones de debugging de pytest (-v y --showlocals).
    """
    # Variables locales para observar con --showlocals
    numerator = 10
    denominator = 2
    expected_result = 4  # Valor incorrecto a propósito
    
    # Realizar la división
    actual_result = numerator / denominator
    
    # Esta aserción fallará porque 10 / 2 = 5, no 4
    assert actual_result == expected_result, \
        f"Expected {expected_result}, but got {actual_result}"
```

**¿Por qué falla?** 
- `10 / 2 = 5.0` (resultado real)
- `expected_result = 4` (valor esperado incorrecto a propósito)
- La aserción `5.0 == 4` es `False`

---

## 🔍 Comparación de Opciones de Pytest

### Opción 1: Traceback Estándar (sin flags)

**Comando:**
```bash
pytest tests/test_calculator.py::test_division
```

**Salida:**
```
================================================================================= FAILURES ================================================================================== 
_______________________________________________________________________________ test_division _______________________________________________________________________________ 

    def test_division():
        ...
>       assert actual_result == expected_result, \
            f"Expected {expected_result}, but got {actual_result}"
E       AssertionError: Expected 4, but got 5.0
E       assert 5.0 == 4

tests\test_calculator.py:108: AssertionError
```

**Información proporcionada:**
- ✅ Ubicación del fallo (línea 108)
- ✅ Mensaje de error (AssertionError)
- ✅ Comparación de valores (5.0 == 4)
- ❌ NO muestra variables locales
- ❌ NO muestra información detallada del entorno

---

### Opción 2: Con `-v` (Verbose)

**Comando:**
```bash
pytest tests/test_calculator.py::test_division -v
```

**Salida:**
```
platform win32 -- Python 3.13.0, pytest-8.4.1, pluggy-1.6.0 -- C:\Users\...\python.exe
cachedir: .pytest_cache
rootdir: D:\8th semester\CALIDAD DE SOFTWARE\PRACTICANDO TESTION 2\project
configfile: pytest.ini
plugins: anyio-3.7.1, Faker-33.0.0, asyncio-0.15.1, cov-7.0.0, flask-1.3.0, mock-3.15.1
collected 1 item

tests/test_calculator.py::test_division FAILED                             [100%]

================================================================================= FAILURES ==================================================================================
...
E       AssertionError: Expected 4, but got 5.0
E       assert 5.0 == 4
```

**Información adicional proporcionada:**
- ✅ **Versión de Python** (3.13.0)
- ✅ **Versión de pytest** (8.4.1)
- ✅ **Ruta completa del ejecutable de Python**
- ✅ **Plugins instalados** (anyio, Faker, asyncio, cov, flask, mock)
- ✅ **Nombre completo del test** (module::function)
- ✅ **Configuración del proyecto** (pytest.ini, rootdir)
- ❌ NO muestra variables locales

**Cuándo usar `-v`:**
- Cuando necesitas saber exactamente qué test falló
- Para ver información del entorno de ejecución
- Para identificar qué plugins están activos
- En CI/CD para logs más detallados

---

### Opción 3: Con `-l` (--showlocals)

**Comando:**
```bash
pytest tests/test_calculator.py::test_division -l
```

**Salida:**
```
================================================================================= FAILURES ================================================================================== 
_______________________________________________________________________________ test_division _______________________________________________________________________________ 

    def test_division():
        ...
>       assert actual_result == expected_result, \
            f"Expected {expected_result}, but got {actual_result}"
E       AssertionError: Expected 4, but got 5.0
E       assert 5.0 == 4

actual_result = 5.0
denominator = 2
expected_result = 4
numerator  = 10

tests\test_calculator.py:108: AssertionError
```

**Información adicional proporcionada:**
- ✅ **Todas las variables locales** en el scope del fallo:
  - `actual_result = 5.0`
  - `denominator = 2`
  - `expected_result = 4`
  - `numerator = 10`
- ✅ Valores exactos de cada variable en el momento del fallo
- ✅ Facilita identificar discrepancias en cálculos

**Cuándo usar `-l`:**
- ✅ Cuando un test falla y necesitas ver los valores exactos
- ✅ Para debugging de lógica compleja
- ✅ Para entender el estado del programa en el punto de fallo
- ✅ Cuando las aserciones involucran múltiples variables

---

### Opción 4: Con `-v -l` (Verbose + ShowLocals) ⭐ RECOMENDADO

**Comando:**
```bash
pytest tests/test_calculator.py::test_division -v -l
```

**Salida:**
```
platform win32 -- Python 3.13.0, pytest-8.4.1, pluggy-1.6.0 -- C:\Users\...\python.exe
cachedir: .pytest_cache
rootdir: D:\8th semester\CALIDAD DE SOFTWARE\PRACTICANDO TESTION 2\project
configfile: pytest.ini
plugins: anyio-3.7.1, Faker-33.0.0, asyncio-0.15.1, cov-7.0.0, flask-1.3.0, mock-3.15.1
collected 1 item

tests/test_calculator.py::test_division FAILED                             [100%]

================================================================================= FAILURES ==================================================================================
_______________________________________________________________________________ test_division _______________________________________________________________________________

    def test_division():
        ...
>       assert actual_result == expected_result, \
            f"Expected {expected_result}, but got {actual_result}"
E       AssertionError: Expected 4, but got 5.0
E       assert 5.0 == 4

actual_result = 5.0
denominator = 2
expected_result = 4
numerator  = 10

tests\test_calculator.py:108: AssertionError
```

**Combina lo mejor de ambos mundos:**
- ✅ Información del entorno (Python, pytest, plugins)
- ✅ Nombre completo del test
- ✅ Variables locales con sus valores
- ✅ Traceback completo

**Cuándo usar `-v -l`:**
- ✅ **Para debugging intensivo** (máxima información)
- ✅ **Cuando no sabes por qué falla un test**
- ✅ **En desarrollo local** para diagnosticar problemas rápidamente
- ✅ **Cuando trabajas con código complejo** con muchas variables

---

## 📊 Tabla Comparativa

| Característica | Sin flags | `-v` | `-l` | `-v -l` |
|----------------|-----------|------|------|---------|
| **Mensaje de error** | ✅ | ✅ | ✅ | ✅ |
| **Ubicación del fallo** | ✅ | ✅ | ✅ | ✅ |
| **Versión de Python** | ❌ | ✅ | ❌ | ✅ |
| **Versión de pytest** | ❌ | ✅ | ❌ | ✅ |
| **Plugins activos** | ❌ | ✅ | ❌ | ✅ |
| **Nombre completo test** | ❌ | ✅ | ❌ | ✅ |
| **Variables locales** | ❌ | ❌ | ✅ | ✅ |
| **Valores de variables** | ❌ | ❌ | ✅ | ✅ |
| **Verbosidad** | Mínima | Alta | Mínima | **Máxima** |
| **Útil para debugging** | ⭐ | ⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ |

---

## 🎓 Lecciones Aprendidas

### 1. **Flag `-v` (verbose)**
```bash
pytest -v
```
- Muestra **información del entorno**
- Ideal para **CI/CD** y logs de producción
- Ayuda a **identificar el contexto** de ejecución

### 2. **Flag `-l` (--showlocals)**
```bash
pytest -l
```
- Muestra **todas las variables locales** en el punto de fallo
- **Esencial para debugging**
- Revela valores que causaron el fallo

### 3. **Combinación `-v -l`** ⭐
```bash
pytest -v -l
```
- **Máxima información** para debugging
- Combina contexto del entorno + estado de variables
- **Recomendado para desarrollo local**

### 4. **Otras Flags Útiles**
```bash
# Mostrar print statements incluso si el test pasa
pytest -v -l -s

# Detener en el primer fallo
pytest -v -l -x

# Mostrar traceback más corto
pytest -v -l --tb=short

# Mostrar traceback más largo (con código fuente)
pytest -v -l --tb=long
```

---

## 💡 Casos de Uso Prácticos

### Escenario 1: Test falla en CI/CD pero pasa localmente
```bash
# Ejecutar con máxima información
pytest -v -l --tb=long
```
Esto te ayudará a identificar diferencias de entorno.

### Escenario 2: Test falla pero no sabes qué variable tiene valor incorrecto
```bash
# Usar --showlocals para ver todas las variables
pytest -l tests/test_calculator.py::test_division
```

### Escenario 3: Múltiples tests fallan
```bash
# Continuar ejecutando todos y ver información detallada
pytest -v -l
```

### Escenario 4: Test falla intermitentemente
```bash
# Ejecutar múltiples veces con máxima información
pytest -v -l --count=10
```

---

## 📝 Comandos de Resumen

```bash
# Cambiar al directorio del proyecto
cd "d:\8th semester\CALIDAD DE SOFTWARE\PRACTICANDO TESTION 2\project"

# 1. Ejecutar test con traceback estándar
pytest tests/test_calculator.py::test_division

# 2. Ejecutar con verbose
pytest tests/test_calculator.py::test_division -v

# 3. Ejecutar con showlocals
pytest tests/test_calculator.py::test_division -l

# 4. Ejecutar con ambas opciones (RECOMENDADO)
pytest tests/test_calculator.py::test_division -v -l

# 5. Ejecutar con máxima verbosidad
pytest tests/test_calculator.py::test_division -v -l -s --tb=long
```

---

## ✅ Checklist del Ejercicio 8

```
✅ Test test_division creado en test_calculator.py
✅ Test falla a propósito (10 / 2 == 4)
✅ Ejecutado con traceback estándar (sin flags)
✅ Ejecutado con -v (verbose)
✅ Ejecutado con -l (--showlocals)
✅ Ejecutado con -v -l (combinado)
✅ Observadas las diferencias en la información mostrada
✅ Documentado el comportamiento de cada opción
```

---

## 🎯 Meta Alcanzada

Has aprendido a:

✅ **Crear tests que fallan** para propósitos de debugging

✅ **Usar `-v`** para obtener información del entorno de ejecución

✅ **Usar `-l`** para ver variables locales en el punto de fallo

✅ **Combinar flags** para maximizar información de debugging

✅ **Interpretar tracebacks** de pytest efectivamente

✅ **Diagnosticar fallos** más rápidamente con las herramientas correctas

---

## 🚀 Próximos Pasos

El Ejercicio 8 continúa con:
- **Parte 2:** Usando `pytest --pdb` para debugging interactivo
- **Parte 3:** Usando `pytest --trace` para step-by-step debugging
- **Parte 4:** Configurando breakpoints con `pytest.set_trace()`

**Tip:** Siempre usa `-v -l` cuando un test falle y no sepas por qué. Te ahorrará mucho tiempo de debugging! 🐛🔍
