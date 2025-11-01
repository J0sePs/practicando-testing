# Calculator Testing Project

![CI](https://img.shields.io/badge/CI-GitHub%20Actions-brightgreen)
![Python](https://img.shields.io/badge/python-3.9%20%7C%203.10%20%7C%203.11%20%7C%203.12%20%7C%203.13-blue)
![pytest](https://img.shields.io/badge/tests-passing-brightgreen)
![Coverage](https://img.shields.io/badge/coverage-45%25-yellow)

## 📋 Descripción

Proyecto de calculadora en Python con testing completo, automatización con tox, y pipeline de CI/CD con GitHub Actions.

Este proyecto implementa una estrategia de testing estructurada y profesional para garantizar la calidad del código.

---

## 🚀 Características

- ✅ **Testing Completo:** Tests con pytest y pytest-cov
- ✅ **Mocking:** Pruebas con monkeypatch para aislar dependencias
- ✅ **Testing Multi-Entorno:** Ejecución en múltiples versiones de Python (3.9-3.13)
- ✅ **Automatización:** Configuración con tox para testing reproducible
- ✅ **CI/CD:** Pipeline automático con GitHub Actions
- ✅ **Cobertura de Código:** Reportes detallados con pytest-cov

---

## 📁 Estructura del Proyecto

```
project/
├── .github/
│   └── workflows/
│       └── ci.yml          # GitHub Actions workflow
├── src/
│   ├── __init__.py
│   └── calculator.py       # Clase Calculator con métodos
├── tests/
│   ├── __init__.py
│   └── test_calculator.py  # Tests con pytest
├── .gitignore              # Archivos ignorados por Git
├── pytest.ini              # Configuración de pytest
├── tox.ini                 # Configuración de tox
├── requirements.txt        # Dependencias del proyecto
└── README.md               # Este archivo
```

---

## 🔧 Instalación

### Requisitos Previos

- Python 3.9 o superior
- pip (gestor de paquetes de Python)
- Git (para control de versiones)

### Pasos de Instalación

```bash
# 1. Clonar el repositorio
git clone https://github.com/TU_USUARIO/calculator-testing-project.git
cd calculator-testing-project

# 2. Crear un entorno virtual (recomendado)
python -m venv venv

# 3. Activar el entorno virtual
# En Windows:
venv\Scripts\activate
# En Linux/Mac:
source venv/bin/activate

# 4. Instalar dependencias
pip install -r requirements.txt
```

---

## 🧪 Ejecutar Tests

### Con pytest (Local)

```bash
# Ejecutar todos los tests
pytest

# Ejecutar tests con verbose
pytest -v

# Ejecutar tests con cobertura
pytest --cov=src --cov-report=term-missing

# Ejecutar tests con reporte HTML de cobertura
pytest --cov=src --cov-report=html
# Ver en: htmlcov/index.html

# Ejecutar solo tests de API
pytest -m api

# Ejecutar tests de un archivo específico
pytest tests/test_calculator.py

# Ejecutar un test específico
pytest tests/test_calculator.py::test_add
```

### Con tox (Multi-Entorno)

```bash
# Ejecutar tests en todas las versiones de Python configuradas
tox

# Ejecutar en una versión específica
tox -e py313

# Recrear entornos (si hay problemas)
tox -r

# Ver lista de entornos configurados
tox -l
```

---

## 📊 Categorías de Tests

### Tests Implementados

- **test_add:** Prueba el método de suma con números positivos, negativos y flotantes
- **test_get_exchange_rate:** Prueba el mocking de una API externa con monkeypatch
- **test_get_exchange_rate_connection_error:** Prueba el manejo de excepciones con mocking

### Marcadores (Markers)

- **api:** Tests que verifican la funcionalidad de las APIs y métodos públicos

```bash
# Ejecutar solo tests marcados como 'api'
pytest -m api

# Ejecutar tests excluyendo 'api'
pytest -m "not api"
```

---

## 🔄 Continuous Integration (CI/CD)

Este proyecto utiliza **GitHub Actions** para ejecutar tests automáticamente en cada push.

### ¿Qué hace el CI?

1. **Testing Multi-Versión:** Ejecuta tests en Python 3.9, 3.10, 3.11, 3.12, y 3.13
2. **Verificación de Calidad:** Ejecuta flake8 para verificar estilo de código
3. **Reporte de Cobertura:** Genera reportes de cobertura de código
4. **Notificaciones:** Envía alertas si algún test falla

### Ver Resultados del CI

1. Ve a la pestaña **Actions** en GitHub
2. Click en el workflow más reciente
3. Verás el estado de cada job (Python 3.9, 3.10, etc.)
4. Click en un job para ver los detalles y logs

---

## 🎯 Cobertura de Código

Estado actual de cobertura:

```
Name                Stmts   Miss  Cover   Missing
-------------------------------------------------
src/__init__.py         0      0   100%
src/calculator.py      11      6    45%   34, 52-58
-------------------------------------------------
TOTAL                  11      6    45%
```

**Meta:** Alcanzar 80%+ de cobertura

---

## 🛠️ Desarrollo

### Agregar Nuevas Funcionalidades

1. **Crear una nueva rama:**
   ```bash
   git checkout -b feature/nueva-funcionalidad
   ```

2. **Escribir el código y los tests**

3. **Ejecutar tests localmente:**
   ```bash
   pytest -v
   ```

4. **Commit y push:**
   ```bash
   git add .
   git commit -m "Add nueva funcionalidad"
   git push origin feature/nueva-funcionalidad
   ```

5. **Crear Pull Request en GitHub**

6. **GitHub Actions ejecutará los tests automáticamente**

7. **Merge cuando los tests pasen ✅**

---

## 📚 Documentación Adicional

- **[GITHUB_ACTIONS_SETUP.md](GITHUB_ACTIONS_SETUP.md):** Guía completa para configurar GitHub Actions
- **[MULTI_PYTHON_SETUP.md](MULTI_PYTHON_SETUP.md):** Instrucciones para instalar múltiples versiones de Python
- **[EJERCICIO_6_COMPLETADO.md](EJERCICIO_6_COMPLETADO.md):** Documentación del ejercicio de tox
- **[README2.md](README2.md):** Guía de configuración de herramientas de testing

---

## 🤝 Contribuir

1. Fork el repositorio
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

---

## 📝 Comandos Útiles

```bash
# Git
git status                  # Ver estado del repositorio
git log --oneline          # Ver historial de commits
git branch                 # Ver ramas

# Testing
pytest -v                  # Tests con verbose
pytest --lf                # Ejecutar solo tests que fallaron
pytest --tb=short          # Traceback corto en errores

# Tox
tox -e py313              # Ejecutar solo Python 3.13
tox -r                    # Recrear entornos
tox -p                    # Ejecutar en paralelo

# Cobertura
pytest --cov=src --cov-report=html   # Generar reporte HTML
```

---

## 🔗 Enlaces Útiles

- **pytest:** https://docs.pytest.org/
- **tox:** https://tox.wiki/
- **GitHub Actions:** https://docs.github.com/en/actions
- **Python:** https://www.python.org/

---

## 📜 Licencia

Este proyecto es de código abierto y está disponible bajo la licencia MIT.

---

## 👥 Autores

- **Tu Nombre** - Trabajo inicial

---

## 🙏 Agradecimientos

- Ejercicios de testing con pytest
- Configuración de CI/CD con GitHub Actions
- Automatización con tox

---

**¡Construido con ❤️ y Python!** 🐍