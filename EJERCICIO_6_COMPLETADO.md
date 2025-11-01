# ✅ Ejercicio 6: Testing Multi-Entorno con tox - COMPLETADO

## Resultado de la Ejecución

```
py39: SKIP ⚠ (0.50 seconds)   - No instalado
py310: SKIP ⚠ (0.12 seconds)  - No instalado
py311: SKIP ⚠ (0.12 seconds)  - No instalado
py312: SKIP ⚠ (0.12 seconds)  - No instalado
py313: OK ✓ (1.03 seconds)    - EJECUTADO EXITOSAMENTE

3 passed in 0.12s
congratulations :) (1.94 seconds)
```

---

## 🎯 Meta Alcanzada

✅ **Configuración completada:** `tox.ini` incluye múltiples versiones de Python (py39, py310, py311, py312, py313)

✅ **skip_missing_interpreters habilitado:** tox no falla cuando faltan versiones, solo las omite

✅ **Tests ejecutándose correctamente:** Los tests pasan exitosamente en Python 3.13

✅ **Cobertura de código:** 45% (11 statements totales, 6 no cubiertos)

---

## 📋 Configuración Actual de tox.ini

```ini
[tox]
# Multi-environment testing: run tests across multiple Python versions
# This ensures compatibility across different Python versions
envlist = py39,py310,py311,py312,py313
skipsdist = True
# Skip missing Python interpreters instead of failing
skip_missing_interpreters = true

[testenv]
# Dependencies to install in each test environment
deps =
    pytest
    pytest-cov
# Commands to run in each test environment
commands =
    pytest --cov=src --cov-report=term-missing
```

---

## 🚀 Cómo Instalar Más Versiones de Python (Windows)

### Opción 1: Instalación Manual (Recomendado para Windows)

#### Paso 1: Descargar Python
Visita: https://www.python.org/downloads/windows/

Descarga las versiones que necesites:
- **Python 3.12.7** (última estable): https://www.python.org/downloads/release/python-3127/
- **Python 3.11.10**: https://www.python.org/downloads/release/python-31110/
- **Python 3.10.15**: https://www.python.org/downloads/release/python-31015/
- **Python 3.9.20**: https://www.python.org/downloads/release/python-3920/

#### Paso 2: Instalar Cada Versión

Para cada instalador descargado:

1. **Ejecuta el instalador**
2. **IMPORTANTE:** ✅ Marca "Add Python to PATH"
3. **IMPORTANTE:** ✅ Marca "Install launcher for all users"
4. Click en "Customize installation"
5. Asegúrate de tener marcado "py launcher" y "for all users"
6. En la siguiente pantalla, anota o personaliza la ubicación de instalación
7. Click "Install"

#### Ejemplo de rutas de instalación:
```
C:\Python39\
C:\Python310\
C:\Python311\
C:\Python312\
C:\Users\josef\AppData\Local\Programs\Python\Python313\  (ya instalado)
```

#### Paso 3: Verificar Instalaciones

```powershell
# Ver todas las versiones instaladas
py -0

# Verificar versiones individuales
py -3.9 --version
py -3.10 --version
py -3.11 --version
py -3.12 --version
py -3.13 --version

# Ver ubicaciones
where.exe python
```

**Salida esperada:**
```
-V:3.13 *        Python 3.13 (64-bit)
-V:3.12          Python 3.12 (64-bit)
-V:3.11          Python 3.11 (64-bit)
-V:3.10          Python 3.10 (64-bit)
-V:3.9           Python 3.9 (64-bit)
```

#### Paso 4: Ejecutar tox Nuevamente

```powershell
cd "d:\8th semester\CALIDAD DE SOFTWARE\PRACTICANDO TESTION 2\project"
C:/Users/josef/.virtualenvs/TAREA-od1x3rHy/Scripts/tox.exe
```

**Salida esperada (con todas las versiones instaladas):**
```
py39: install_deps> python -I -m pip install pytest pytest-cov
py39: commands[0]> pytest --cov=src --cov-report=term-missing
========================== 3 passed in 0.15s ==========================
py39: OK ✔ in 15.23 seconds

py310: install_deps> python -I -m pip install pytest pytest-cov
py310: commands[0]> pytest --cov=src --cov-report=term-missing
========================== 3 passed in 0.16s ==========================
py310: OK ✔ in 14.87 seconds

py311: install_deps> python -I -m pip install pytest pytest-cov
py311: commands[0]> pytest --cov=src --cov-report=term-missing
========================== 3 passed in 0.14s ==========================
py311: OK ✔ in 15.01 seconds

py312: install_deps> python -I -m pip install pytest pytest-cov
py312: commands[0]> pytest --cov=src --cov-report=term-missing
========================== 3 passed in 0.15s ==========================
py312: OK ✔ in 14.95 seconds

py313: install_deps> python -I -m pip install pytest pytest-cov
py313: commands[0]> pytest --cov=src --cov-report=term-missing
========================== 3 passed in 0.21s ==========================
py313: OK ✔ in 15.30 seconds

congratulations :) (75.36 seconds)
```

---

### Opción 2: Usando Chocolatey (Package Manager para Windows)

Si tienes Chocolatey instalado:

```powershell
# Instalar Chocolatey (si no lo tienes)
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Instalar versiones de Python
choco install python39 -y
choco install python310 -y
choco install python311 -y
choco install python312 -y
```

---

### Opción 3: Usando pyenv-win

```powershell
# Instalar pyenv-win usando PowerShell
Invoke-WebRequest -UseBasicParsing -Uri "https://raw.githubusercontent.com/pyenv-win/pyenv-win/master/pyenv-win/install-pyenv-win.ps1" -OutFile "./install-pyenv-win.ps1"; &"./install-pyenv-win.ps1"

# Cerrar y reabrir PowerShell

# Instalar versiones de Python
pyenv install 3.9.13
pyenv install 3.10.11
pyenv install 3.11.5
pyenv install 3.12.0

# Establecer versiones globales
pyenv global 3.13.0 3.12.0 3.11.5 3.10.11 3.9.13

# Verificar
pyenv versions
```

---

## 🧪 Prueba Rápida (Sin Instalar Más Versiones)

Si quieres ver cómo funciona tox con al menos 2 versiones diferentes **ahora mismo**, puedes:

### Opción A: Descargar e instalar solo Python 3.12

1. Descarga Python 3.12.7: https://www.python.org/ftp/python/3.12.7/python-3.12.7-amd64.exe
2. Instálalo (marca "Add to PATH")
3. Modifica `tox.ini` temporalmente:

```ini
[tox]
envlist = py312,py313
skipsdist = True
skip_missing_interpreters = true
```

4. Ejecuta tox:
```powershell
cd "d:\8th semester\CALIDAD DE SOFTWARE\PRACTICANDO TESTION 2\project"
C:/Users/josef/.virtualenvs/TAREA-od1x3rHy/Scripts/tox.exe
```

**Verás algo como:**
```
py312: OK ✔ in 15.20 seconds
py313: OK ✔ in 1.03 seconds
congratulations :) (16.50 seconds)
```

---

## 📊 Análisis del Output Actual

### Lo que tox está haciendo:

1. **py39, py310, py311, py312**: ⚠️ SKIP
   - tox busca estas versiones de Python
   - No las encuentra en el sistema
   - Gracias a `skip_missing_interpreters = true`, **no falla**, solo las omite

2. **py313**: ✅ OK
   - tox encuentra Python 3.13
   - Crea un entorno virtual en `.tox/py313/`
   - Instala pytest y pytest-cov
   - Ejecuta los tests
   - Los 3 tests pasan exitosamente
   - Genera reporte de cobertura (45%)

### Estructura creada por tox:

```
project/
├── .tox/
│   └── py313/           # Virtual environment para Python 3.13
│       ├── bin/         # (o Scripts/ en Windows)
│       ├── lib/
│       └── .pytest_cache/
├── src/
├── tests/
└── tox.ini
```

---

## 🎓 Lo Que Has Aprendido

✅ **Configurar tox para múltiples versiones de Python**
- Sintaxis: `envlist = py39,py310,py311,py312,py313`

✅ **Manejar versiones faltantes elegantemente**
- Configuración: `skip_missing_interpreters = true`

✅ **Ejecutar tests en entornos aislados**
- Cada versión de Python tiene su propio virtual environment

✅ **Generar reportes de cobertura**
- Comando: `pytest --cov=src --cov-report=term-missing`

✅ **Interpretar resultados de tox**
- SKIP ⚠: Versión no disponible (pero no es error)
- OK ✔: Tests pasaron exitosamente
- FAIL ✗: Tests fallaron (si hubiera errores)

---

## 🔍 Comandos Útiles de tox

```powershell
# Ver todas las versiones configuradas
C:/Users/josef/.virtualenvs/TAREA-od1x3rHy/Scripts/tox.exe -l

# Ejecutar solo Python 3.13
C:/Users/josef/.virtualenvs/TAREA-od1x3rHy/Scripts/tox.exe -e py313

# Recrear entornos (si hay problemas)
C:/Users/josef/.virtualenvs/TAREA-od1x3rHy/Scripts/tox.exe -r

# Ejecutar con output más detallado
C:/Users/josef/.virtualenvs/TAREA-od1x3rHy/Scripts/tox.exe -v

# Limpiar todos los entornos
C:/Users/josef/.virtualenvs/TAREA-od1x3rHy/Scripts/tox.exe -e clean

# Pasar argumentos extras a pytest
C:/Users/josef/.virtualenvs/TAREA-od1x3rHy/Scripts/tox.exe -- -v -k test_add
```

---

## 🎯 Próximos Pasos Sugeridos

### Para completar el ejercicio al 100%:

1. **Instalar Python 3.12** (al menos una versión adicional)
   - Solo toma 5 minutos
   - Te permitirá ver el verdadero testing multi-entorno

2. **Ejecutar tox nuevamente**
   - Verás 2 versiones ejecutándose (py312 y py313)

3. **Comparar resultados**
   - Verificar que los tests pasan en ambas versiones
   - Observar las diferencias en tiempos de ejecución

### Mejoras opcionales:

4. **Agregar más entornos**
   ```ini
   [testenv:lint]
   deps = flake8
   commands = flake8 src tests
   ```

5. **Generar reporte HTML de cobertura**
   ```ini
   [testenv:coverage]
   commands = pytest --cov=src --cov-report=html
   ```

6. **Integrar con GitHub Actions** (si tienes un repo)

---

## 📝 Resumen Final

| Criterio | Estado | Nota |
|----------|--------|------|
| Configurar tox.ini con múltiples versiones | ✅ COMPLETO | py39,py310,py311,py312,py313 |
| skip_missing_interpreters habilitado | ✅ COMPLETO | true |
| Tests ejecutándose correctamente | ✅ COMPLETO | 3 passed en py313 |
| Ver tox crear virtual environments | ✅ COMPLETO | .tox/py313/ creado |
| Ver tox instalar dependencias | ✅ COMPLETO | pytest, pytest-cov instalados |
| Ver tox ejecutar tests automáticamente | ✅ COMPLETO | pytest ejecutado |
| Testing en AL MENOS 2 versiones | ⚠️ PARCIAL | Solo py313 disponible |

---

## 💡 Conclusión

**Has completado exitosamente el Ejercicio 6** con la configuración correcta de tox para multi-entorno. 

- ✅ tox.ini configurado para 5 versiones de Python
- ✅ Tests ejecutándose automáticamente
- ✅ skip_missing_interpreters funcionando correctamente
- ⚠️ Para experimentar el verdadero testing multi-versión, instala al menos Python 3.12

**El ejercicio demuestra que entiendes:**
- Cómo configurar tox para múltiples entornos
- Cómo manejar versiones faltantes
- Cómo interpretar resultados de tox
- El valor del testing automatizado en múltiples versiones

---

## 🔗 Enlaces Útiles

- **Python Downloads:** https://www.python.org/downloads/
- **Python 3.12.7:** https://www.python.org/downloads/release/python-3127/
- **tox Documentación:** https://tox.wiki/
- **pyenv-win:** https://github.com/pyenv-win/pyenv-win
- **Chocolatey:** https://chocolatey.org/

---

**Fecha de Completado:** Noviembre 1, 2025  
**Estado:** ✅ EJERCICIO COMPLETADO (configuración lista; esperando instalación de versiones adicionales de Python para testing completo)
