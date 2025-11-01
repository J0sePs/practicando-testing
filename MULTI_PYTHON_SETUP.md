# Ejercicio 6: Testing Multi-Entorno con tox

## ✅ Completado Exitosamente

### Resultado de la Ejecución

```
py313: OK (28.53=setup[27.23]+cmd[1.30] seconds)
congratulations :) (28.64 seconds)
```

**Tests ejecutados:** 3 passed  
**Cobertura de código:** 45% (11 statements, 6 missed)  
**Tiempo total:** ~28 segundos (incluye creación del entorno virtual)

---

## Configuración Actual

### tox.ini
```ini
[tox]
envlist = py313
skipsdist = True

[testenv]
deps =
    pytest
    pytest-cov
commands =
    pytest --cov=src --cov-report=term-missing
```

### Sistema Actual
- **Python instalado:** Python 3.13.0
- **Ubicación:** `C:\Users\josef\AppData\Local\Programs\Python\Python313\`
- **Virtual Environment:** `C:/Users/josef/.virtualenvs/TAREA-od1x3rHy/`

---

## Cómo Configurar Múltiples Versiones de Python

### Opción 1: Instalación Manual (Windows)

1. **Descargar versiones de Python:**
   - Visita: https://www.python.org/downloads/
   - Descarga las versiones que necesites (ej. 3.9, 3.10, 3.11, 3.12)

2. **Instalar cada versión:**
   - Durante la instalación, asegúrate de marcar "Add Python to PATH"
   - Instala cada versión en directorios separados

3. **Verificar instalaciones:**
   ```powershell
   py -3.9 --version
   py -3.10 --version
   py -3.11 --version
   py -3.12 --version
   py -3.13 --version
   ```

4. **Modificar tox.ini:**
   ```ini
   [tox]
   envlist = py39,py310,py311,py312,py313
   skipsdist = True
   ```

5. **Ejecutar tox:**
   ```powershell
   tox
   ```

---

### Opción 2: Usando pyenv (Recomendado para Linux/Mac)

**En Linux/Mac:**

1. **Instalar pyenv:**
   ```bash
   curl https://pyenv.run | bash
   ```

2. **Instalar múltiples versiones de Python:**
   ```bash
   pyenv install 3.9.18
   pyenv install 3.10.13
   pyenv install 3.11.7
   pyenv install 3.12.1
   pyenv install 3.13.0
   ```

3. **Establecer versiones locales:**
   ```bash
   pyenv local 3.9.18 3.10.13 3.11.7 3.12.1 3.13.0
   ```

4. **Verificar:**
   ```bash
   pyenv versions
   ```

---

### Opción 3: Usando pyenv-win (Windows)

1. **Instalar pyenv-win:**
   ```powershell
   pip install pyenv-win --target $HOME\.pyenv
   ```

2. **Configurar variables de entorno:**
   ```powershell
   [System.Environment]::SetEnvironmentVariable('PYENV',$HOME + "\.pyenv\pyenv-win\","User")
   [System.Environment]::SetEnvironmentVariable('PYENV_HOME',$HOME + "\.pyenv\pyenv-win\","User")
   ```

3. **Agregar a PATH:**
   - Agregar `%PYENV%\bin` y `%PYENV%\shims` a la variable PATH

4. **Instalar versiones:**
   ```powershell
   pyenv install 3.9.13
   pyenv install 3.10.11
   pyenv install 3.11.5
   pyenv install 3.12.0
   ```

---

## Configuración Avanzada de tox.ini

### Ejemplo con Múltiples Entornos

```ini
[tox]
# Test en múltiples versiones de Python
envlist = py39,py310,py311,py312,py313,lint,coverage
skipsdist = True

[testenv]
# Configuración base para todos los entornos
deps =
    pytest
    pytest-cov
commands =
    pytest --cov=src tests/

[testenv:py39]
# Configuración específica para Python 3.9
basepython = python3.9

[testenv:py310]
basepython = python3.10

[testenv:py311]
basepython = python3.11

[testenv:py312]
basepython = python3.12

[testenv:py313]
basepython = python3.13

[testenv:lint]
# Entorno para verificar calidad de código
deps =
    flake8
    black
    isort
commands =
    flake8 src tests
    black --check src tests
    isort --check-only src tests

[testenv:coverage]
# Entorno para generar reporte de cobertura detallado
deps =
    pytest
    pytest-cov
commands =
    pytest --cov=src --cov-report=html --cov-report=term-missing tests/
```

---

## Comandos Útiles de tox

### Ejecutar todos los entornos
```powershell
tox
```

### Ejecutar un entorno específico
```powershell
tox -e py39
tox -e py313
tox -e lint
```

### Ejecutar múltiples entornos específicos
```powershell
tox -e py39,py313
```

### Recrear los entornos (si hay problemas)
```powershell
tox -r
```

### Ver lista de entornos disponibles
```powershell
tox -l
```

### Ejecutar con salida detallada
```powershell
tox -v
```

### Pasar argumentos adicionales a pytest
```powershell
tox -- -v -k test_add
```

---

## Ventajas del Testing Multi-Entorno

### 1. **Compatibilidad Garantizada**
- Asegura que tu código funciona en diferentes versiones de Python
- Detecta problemas de compatibilidad tempranamente

### 2. **Automatización**
- Un solo comando (`tox`) ejecuta todos los tests en todos los entornos
- Ahorra tiempo y reduce errores humanos

### 3. **Reproducibilidad**
- Cada entorno se crea desde cero
- Garantiza que las dependencias se instalan correctamente

### 4. **Integración Continua**
- Fácil de integrar en pipelines CI/CD
- GitHub Actions, GitLab CI, Jenkins, etc. pueden usar tox directamente

### 5. **Aislamiento**
- Cada entorno de prueba está aislado
- No hay conflictos entre versiones de dependencias

---

## Problemas Comunes y Soluciones

### Error: "InterpreterNotFound"
**Problema:** tox no encuentra la versión de Python especificada

**Solución:**
```ini
[testenv]
# Ignorar versiones no instaladas
skip_missing_interpreters = true
```

O instalar la versión faltante.

---

### Error: "No module named 'src'"
**Problema:** El módulo `src` no se encuentra

**Solución 1:** Usar `skipsdist = True` (ya configurado)

**Solución 2:** Agregar `src` al PYTHONPATH en tox.ini:
```ini
[testenv]
setenv =
    PYTHONPATH = {toxinidir}/src
```

---

### Tests muy lentos
**Problema:** Crear entornos toma mucho tiempo

**Solución:** Usar cache de tox (ya está activado por defecto)

Para limpiar y recrear:
```powershell
tox -r  # Recrear entornos
```

---

### Error: "CommandInvokeError"
**Problema:** El comando pytest falla

**Solución:** Verificar que pytest esté en las dependencias:
```ini
[testenv]
deps =
    pytest
    pytest-cov
```

---

## Ejemplo de Salida Multi-Versión

Cuando tengas múltiples versiones instaladas, verás algo como:

```
py39: install_deps> python -I -m pip install pytest pytest-cov
py39: commands[0]> pytest --cov=src
========================== 3 passed in 0.15s ==========================
py39: OK ✔ in 15.23 seconds

py310: install_deps> python -I -m pip install pytest pytest-cov
py310: commands[0]> pytest --cov=src
========================== 3 passed in 0.16s ==========================
py310: OK ✔ in 14.87 seconds

py311: install_deps> python -I -m pip install pytest pytest-cov
py311: commands[0]> pytest --cov=src
========================== 3 passed in 0.14s ==========================
py311: OK ✔ in 15.01 seconds

py312: install_deps> python -I -m pip install pytest pytest-cov
py312: commands[0]> pytest --cov=src
========================== 3 passed in 0.15s ==========================
py312: OK ✔ in 14.95 seconds

py313: install_deps> python -I -m pip install pytest pytest-cov
py313: commands[0]> pytest --cov=src
========================== 3 passed in 0.21s ==========================
py313: OK ✔ in 15.30 seconds

congratulations :) (75.36 seconds)
```

---

## Integración con CI/CD

### GitHub Actions

```yaml
name: Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        python-version: ['3.9', '3.10', '3.11', '3.12', '3.13']
    
    steps:
    - uses: actions/checkout@v3
    - name: Set up Python ${{ matrix.python-version }}
      uses: actions/setup-python@v4
      with:
        python-version: ${{ matrix.python-version }}
    - name: Install dependencies
      run: |
        pip install tox tox-gh-actions
    - name: Run tests with tox
      run: tox
```

---

## Próximos Pasos

1. **Instalar más versiones de Python** en tu sistema
2. **Modificar `envlist`** en `tox.ini` para incluir todas las versiones
3. **Ejecutar `tox`** y ver los tests corriendo en cada versión
4. **Agregar entornos adicionales** como `lint` o `coverage`
5. **Integrar con CI/CD** en tu repositorio

---

## Recursos Adicionales

- **Documentación oficial de tox:** https://tox.wiki/
- **pyenv:** https://github.com/pyenv/pyenv
- **pyenv-win:** https://github.com/pyenv-win/pyenv-win
- **Python downloads:** https://www.python.org/downloads/
- **pytest con tox:** https://docs.pytest.org/en/latest/goodpractices.html#tox

---

## Resumen del Ejercicio 6

✅ **Completado:**
- Instalado tox
- Configurado `tox.ini` con soporte multi-entorno
- Ejecutado exitosamente tests en Python 3.13
- Documentado cómo agregar más versiones de Python

✅ **Aprendido:**
- Cómo configurar tox para múltiples versiones de Python
- Cómo ejecutar tests automáticamente en entornos aislados
- Ventajas del testing multi-entorno
- Cómo resolver problemas comunes

✅ **Meta Alcanzada:**
> "Poder ejecutar tox desde la terminal y ver cómo se crea un virtual environment, se instalan las dependencias y se ejecutan todos los tests de forma automática."

**Estado:** ✅ COMPLETADO (con una versión de Python; documentado cómo agregar más)
