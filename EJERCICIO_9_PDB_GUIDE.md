# 🐛 Ejercicio 9: Guía de Uso de PDB con pytest

## 📋 Sesión de Debugging con --pdb

### Comando para iniciar PDB:
```bash
pytest tests/test_calculator.py::test_division --pdb
```

### Salida esperada cuando entra al debugger:

```
============================================================================ test session starts ============================================================================
platform win32 -- Python 3.13.0, pytest-8.4.1, pluggy-1.6.0
rootdir: D:\8th semester\CALIDAD DE SOFTWARE\PRACTICANDO TESTION 2\project
configfile: pytest.ini
collected 1 item

tests\test_calculator.py F
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> traceback >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

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
>       assert actual_result == expected_result, \
            f"Expected {expected_result}, but got {actual_result}"
E       AssertionError: Expected 4, but got 5.0
E       assert 5.0 == 4

tests\test_calculator.py:108: AssertionError
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> entering PDB >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> PDB post_mortem >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
> d:\8th semester\calidad de software\practicando testion 2\project\tests\test_calculator.py(108)test_division()
-> assert actual_result == expected_result,             f"Expected {expected_result}, but got {actual_result}"
(Pdb)
```

### Comandos útiles en PDB:

#### 1. Ver variables locales
```python
(Pdb) p numerator
10

(Pdb) p denominator
2

(Pdb) p actual_result
5.0

(Pdb) p expected_result
4
```

#### 2. Ver todas las variables locales
```python
(Pdb) locals()
{'numerator': 10, 'denominator': 2, 'expected_result': 4, 'actual_result': 5.0}
```

#### 3. Evaluar expresiones
```python
(Pdb) numerator / denominator
5.0

(Pdb) actual_result == expected_result
False

(Pdb) actual_result == 5.0
True
```

#### 4. Ver el código alrededor del fallo
```python
(Pdb) list
 98         Ejercicio 8: Este test falla intencionalmente para demostrar
 99         las opciones de debugging de pytest (-v y --showlocals).
100         """
101         # Variables locales para observar con --showlocals
102         numerator = 10
103         denominator = 2
104         expected_result = 4  # Valor incorrecto a propósito
105
106         # Realizar la división
107         actual_result = numerator / denominator
108  ->     assert actual_result == expected_result, \
109                 f"Expected {expected_result}, but got {actual_result}"
```

#### 5. Ver el traceback completo
```python
(Pdb) where
> d:\8th semester\calidad de software\practicando testion 2\project\tests\test_calculator.py(108)test_division()
-> assert actual_result == expected_result,             f"Expected {expected_result}, but got {actual_result}"
```

#### 6. Ayuda
```python
(Pdb) help
Documented commands (type help <topic>):
========================================
EOF    c          d        h         list      q        rv       undisplay
a      cl         debug    help      ll        quit     s        unt
alias  clear      disable  ignore    longlist  r        source   until
args   commands   display  interact  n         restart  step     up
b      condition  down     j         next      return   tbreak   w
break  cont       enable   jump      p         retval   u        whatis
bt     continue   exit     l         pp        run      unalias  where
```

#### 7. Salir del debugger
```python
(Pdb) q
```

---

## 🎯 Comandos PDB más Útiles

| Comando | Descripción | Ejemplo |
|---------|-------------|---------|
| `p variable` | Imprime el valor de una variable | `p numerator` |
| `pp variable` | Pretty print (formato legible) | `pp locals()` |
| `locals()` | Muestra todas las variables locales | `locals()` |
| `list` o `l` | Muestra el código alrededor | `l` |
| `where` o `w` | Muestra el traceback | `w` |
| `up` | Sube un nivel en el stack | `up` |
| `down` | Baja un nivel en el stack | `down` |
| `c` o `continue` | Continúa la ejecución | `c` |
| `n` o `next` | Ejecuta la siguiente línea | `n` |
| `s` o `step` | Entra en funciones | `s` |
| `q` o `quit` | Sale del debugger | `q` |
| `h` o `help` | Muestra ayuda | `h` o `h p` |

---

## 💡 Flujo de Trabajo de Debugging

### 1. Test falla → Entra automáticamente a PDB
```bash
pytest tests/test_calculator.py::test_division --pdb
```

### 2. Inspecciona variables
```python
(Pdb) p actual_result
5.0
(Pdb) p expected_result
4
```

### 3. Identifica el problema
- `actual_result = 5.0` (correcto: 10 / 2 = 5)
- `expected_result = 4` (incorrecto)
- **Problema:** El valor esperado está mal

### 4. Sale del debugger
```python
(Pdb) q
```

### 5. Corrige el código
Cambiar `expected_result = 4` a `expected_result = 5`

### 6. Ejecuta solo el test que falló
```bash
pytest --lf
```

---

## 🔍 Diferencias entre opciones de debugging

| Opción | Cuándo usar | Interactivo |
|--------|-------------|-------------|
| `pytest -l` | Ver variables sin interacción | ❌ No |
| `pytest --pdb` | Debugging interactivo completo | ✅ Sí |
| `pytest --trace` | Parar antes de ejecutar el test | ✅ Sí |
| `pytest --pdbcls` | Usar debugger personalizado | ✅ Sí |

---

## 🚀 Casos de Uso de --pdb

### ✅ Cuándo usar --pdb:
1. Un test falla y no sabes por qué
2. Necesitas inspeccionar el estado del programa
3. Quieres evaluar expresiones en el contexto del fallo
4. Necesitas navegar por el stack trace
5. Debugging de lógica compleja

### ❌ Cuándo NO usar --pdb:
1. En CI/CD (no es interactivo)
2. Cuando ejecutas múltiples tests
3. Si ya sabes el problema (usa `-l` en su lugar)
4. Para tests automatizados

---

## 📝 Ejemplo Completo de Sesión PDB

```python
# Test ejecutándose...
(Pdb) p numerator        # Imprime numerator
10
(Pdb) p denominator      # Imprime denominator
2
(Pdb) p actual_result    # Imprime actual_result
5.0
(Pdb) p expected_result  # Imprime expected_result
4
(Pdb) numerator / denominator  # Evalúa expresión
5.0
(Pdb) actual_result == 5  # Verifica condición
True
(Pdb) expected_result == 5  # Verifica condición
False
(Pdb) locals()  # Ve todas las variables
{'numerator': 10, 'denominator': 2, 'expected_result': 4, 'actual_result': 5.0}
(Pdb) q  # Sale del debugger
```

---

## 🎓 Tips Pro para PDB

### 1. Combinar con verbose
```bash
pytest --pdb -v
```

### 2. Detener en el primer fallo
```bash
pytest --pdb -x
```

### 3. Usar con coverage
```bash
pytest --pdb --cov=src
```

### 4. Expresiones complejas
```python
(Pdb) [x for x in locals() if not x.startswith('_')]
['numerator', 'denominator', 'expected_result', 'actual_result']
```

### 5. Ejecutar código arbitrario
```python
(Pdb) result = numerator * 2
(Pdb) p result
20
```

---

## ⚡ Shortcuts de PDB

- `!!` - Repite el último comando
- `!statement` - Ejecuta statement de Python
- Enter (vacío) - Repite el último comando
- Ctrl+D - Sale del debugger (igual que `q`)

---

Esta guía te ayudará a dominar el debugging interactivo con PDB en pytest! 🐛🔍
