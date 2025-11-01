# Guía de Configuración de Herramientas de Testing en Python

## Secciones de Configuración Estándar

Esta guía explica las diferentes secciones que puedes usar en archivos de configuración de Python como `tox.ini`, `pytest.ini`, `setup.cfg`, o `pyproject.toml`.

---

## 1. **pytest** (Framework de Testing)

```ini
[pytest]
# o también
[tool:pytest]
```

### Opciones comunes:
```ini
[pytest]
testpaths = tests
python_files = test_*.py
python_classes = Test*
python_functions = test_*
addopts = -v --tb=short
markers =
    api: marks tests as API tests
    slow: marks tests as slow
    unit: marks tests as unit tests
```

---

## 2. **tox** (Automatización de Tests en Múltiples Entornos)

```ini
[tox]
envlist = py39,py310,py311
skipsdist = True

[testenv]
deps =
    pytest
    pytest-cov
commands =
    pytest --cov=src

[testenv:lint]
deps =
    flake8
commands =
    flake8 src tests
```

### Secciones disponibles:
- `[tox]` - Configuración global
- `[testenv]` - Configuración base para todos los entornos
- `[testenv:nombre]` - Configuración específica para un entorno

---

## 3. **coverage** (Análisis de Cobertura de Código)

```ini
[coverage:run]
source = src
omit = 
    */tests/*
    */__pycache__/*
    */venv/*

[coverage:report]
exclude_lines =
    pragma: no cover
    def __repr__
    raise AssertionError
    raise NotImplementedError
    if __name__ == .__main__.:
precision = 2

[coverage:html]
directory = htmlcov
```

### Secciones disponibles:
- `[coverage:run]` - Configuración de ejecución
- `[coverage:report]` - Configuración de reportes
- `[coverage:html]` - Configuración de reportes HTML
- `[coverage:xml]` - Configuración de reportes XML

---

## 4. **flake8** (Linter de Código)

```ini
[flake8]
max-line-length = 100
max-complexity = 10
exclude = 
    .git,
    __pycache__,
    .tox,
    venv,
    .venv,
    dist,
    build
ignore = E203,W503,E501
per-file-ignores =
    __init__.py:F401
```

---

## 5. **mypy** (Type Checker)

```ini
[mypy]
python_version = 3.9
warn_return_any = True
warn_unused_configs = True
disallow_untyped_defs = True

[mypy-nombre_modulo.*]
ignore_missing_imports = True
```

---

## 6. **isort** (Ordenar Imports)

```ini
[isort]
profile = black
line_length = 100
skip = .tox,venv,.venv
multi_line_output = 3
include_trailing_comma = True
```

---

## 7. **pylint** (Linter Avanzado)

```ini
[pylint]
max-line-length = 100
disable = 
    C0111,  # missing-docstring
    R0903,  # too-few-public-methods
```

---

## 8. **black** (Formateador de Código)

```ini
[tool:black]
line-length = 100
target-version = py39
include = \.pyi?$
exclude = /(\.git|\.tox|venv|build|dist)/
```

---

## Archivos de Configuración

### `tox.ini`
Puede contener configuración de: **tox**, **pytest**, **coverage**, **flake8**, **isort**, **mypy**

### `pytest.ini`
Solo para **pytest**

### `setup.cfg`
Puede contener configuración de **TODAS** las herramientas anteriores

### `pyproject.toml` (Formato Moderno)
Puede contener configuración de todas las herramientas usando sintaxis TOML:

```toml
[tool.pytest.ini_options]
testpaths = ["tests"]
python_files = ["test_*.py"]

[tool.coverage.run]
source = ["src"]

[tool.black]
line-length = 100

[tool.isort]
profile = "black"
```

---

## Ejemplo Completo de `tox.ini`

```ini
[tox]
envlist = py39,py310,lint,coverage
skipsdist = True

[testenv]
deps =
    pytest
    pytest-cov
commands =
    pytest --cov=src tests/

[testenv:lint]
deps =
    flake8
    mypy
    black
    isort
commands =
    flake8 src tests
    mypy src
    black --check src tests
    isort --check-only src tests

[testenv:coverage]
deps =
    pytest
    pytest-cov
commands =
    pytest --cov=src --cov-report=html --cov-report=term tests/

[pytest]
testpaths = tests
python_files = test_*.py
python_classes = Test*
python_functions = test_*
addopts = -v --tb=short --strict-markers
markers =
    api: marks tests as API tests
    slow: marks tests as slow (deselect with '-m "not slow"')
    unit: marks tests as unit tests
    integration: marks tests as integration tests

[coverage:run]
source = src
omit = 
    */tests/*
    */__pycache__/*
    */venv/*
    */.tox/*

[coverage:report]
exclude_lines =
    pragma: no cover
    def __repr__
    raise AssertionError
    raise NotImplementedError
    if __name__ == .__main__.:
    if TYPE_CHECKING:
    @abstractmethod
precision = 2
show_missing = True

[flake8]
max-line-length = 100
max-complexity = 10
exclude = 
    .git,
    __pycache__,
    .tox,
    venv,
    dist,
    build
ignore = E203,W503

[mypy]
python_version = 3.9
warn_return_any = True
warn_unused_configs = True
disallow_untyped_defs = False
ignore_missing_imports = True

[isort]
profile = black
line_length = 100
skip = .tox,venv,.venv
```

---

## Comandos Útiles

```bash
# Ejecutar tox (todos los entornos)
tox

# Ejecutar un entorno específico
tox -e py39
tox -e lint
tox -e coverage

# Ejecutar pytest directamente
pytest

# Ejecutar pytest con cobertura
pytest --cov=src --cov-report=html

# Ejecutar flake8
flake8 src tests

# Ejecutar mypy
mypy src

# Ejecutar black (formatear código)
black src tests

# Ejecutar isort (ordenar imports)
isort src tests
```

---

## Notas Importantes

1. **Los nombres de las secciones son fijos** - No puedes cambiar `[tox]`, `[pytest]`, `[flake8]`, etc. Son parte del estándar de cada herramienta.

2. **Un archivo puede tener múltiples secciones** - `tox.ini` puede contener configuración para tox, pytest, coverage, flake8, etc.

3. **Jerarquía de archivos** - Si existen múltiples archivos de configuración, las herramientas los buscan en este orden:
   - `pyproject.toml`
   - `tox.ini` o `pytest.ini` (específicos)
   - `setup.cfg`

4. **Formato TOML vs INI**:
   - Archivos `.ini` y `.cfg`: usan sintaxis INI (`[sección]`)
   - `pyproject.toml`: usa sintaxis TOML (`[tool.herramienta]`)

---

## Referencias

- pytest: https://docs.pytest.org/
- tox: https://tox.wiki/
- coverage: https://coverage.readthedocs.io/
- flake8: https://flake8.pycqa.org/
- mypy: https://mypy.readthedocs.io/
- black: https://black.readthedocs.io/
- isort: https://pycqa.github.io/isort/
