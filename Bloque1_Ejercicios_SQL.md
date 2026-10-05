# Bloque 1. Ejercicios de SQL

## Instrucciones

De acuerdo con la tabla `Automovil`, construir las sentencias SQL que resuelvan cada consulta y presentar el resultado.

## Tabla Automovil

| idAutomovil | marca | modelo | anio | kilometraje | municipio | pasajero | placa |
|---|---|---|---|---|---|---|---|
| 5671 | Nissan | Versa | 2024 | 43456 | Pachuca | 4 | HJC123E |
| 5672 | Honda | City | 2025 | 9832 | Tulancingo | 5 | HJC124E |
| 5673 | Toyota | Corolla | 2023 | 67921 | Actopan | 3 | HJC125E |
| 5674 | Nissan | Versa | 2023 | 63456 | Pachuca | 4 | HJC126E |
| 5675 | Honda | City | 2024 | 19832 | Tulancingo | 4 | HJC133E |
| 5676 | Toyota | Corolla | 2024 | 47921 | Actopan | 5 | HJC133E |
| 5677 | Nissan | Versa | 2022 | 83456 | Pachuca | 4 | HJC223E |
| 5678 | Honda | City | 2023 | 49832 | Tulancingo | 5 | HJC223E |
| 5679 | Toyota | Corolla | 2021 | 97921 | Actopan | 3 | HJC223E |

## Preparación de la base de datos

```sql
CREATE DATABASE IF NOT EXISTS bloque1_sql;
USE bloque1_sql;

DROP TABLE IF EXISTS Automovil;

CREATE TABLE Automovil (
    idAutomovil INT PRIMARY KEY,
    marca       VARCHAR(30),
    modelo      VARCHAR(30),
    anio        INT,
    kilometraje INT,
    municipio   VARCHAR(30),
    pasajero    INT,
    placa       VARCHAR(10)
);

INSERT INTO Automovil VALUES
(5671, 'Nissan', 'Versa',   2024, 43456, 'Pachuca',    4, 'HJC123E'),
(5672, 'Honda',  'City',    2025,  9832, 'Tulancingo', 5, 'HJC124E'),
(5673, 'Toyota', 'Corolla', 2023, 67921, 'Actopan',    3, 'HJC125E'),
(5674, 'Nissan', 'Versa',   2023, 63456, 'Pachuca',    4, 'HJC126E'),
(5675, 'Honda',  'City',    2024, 19832, 'Tulancingo', 4, 'HJC133E'),
(5676, 'Toyota', 'Corolla', 2024, 47921, 'Actopan',    5, 'HJC133E'),
(5677, 'Nissan', 'Versa',   2022, 83456, 'Pachuca',    4, 'HJC223E'),
(5678, 'Honda',  'City',    2023, 49832, 'Tulancingo', 5, 'HJC223E'),
(5679, 'Toyota', 'Corolla', 2021, 97921, 'Actopan',    3, 'HJC223E');
```

## Consultas

### 1. Vehículos con capacidad para más de 4 pasajeros

Incluye los datos de marca, municipio y placa.

**Solución**

```sql
SELECT marca, municipio, placa
  FROM Automovil
 WHERE pasajero > 4;
```

**Salida**

| marca | municipio | placa |
|---|---|---|
| Honda | Tulancingo | HJC124E |
| Toyota | Actopan | HJC133E |
| Honda | Tulancingo | HJC223E |

---

### 2. Vehículos que trabajan en Actopan

Incluye los datos de placa, pasajero, modelo y anio.

**Solución**

```sql
SELECT placa, pasajero, modelo, anio
  FROM Automovil
 WHERE municipio = 'Actopan';
```

**Salida**

| placa | pasajero | modelo | anio |
|---|---|---|---|
| HJC125E | 3 | Corolla | 2023 |
| HJC133E | 5 | Corolla | 2024 |
| HJC223E | 3 | Corolla | 2021 |

---

### 3. Vehículos cuyo año de inicio de operación sea menor o igual a 2023

Incluye los datos de marca, modelo y kilometraje.

**Solución**

```sql
SELECT marca, modelo, kilometraje
  FROM Automovil
 WHERE anio <= 2023;
```

**Salida**

| marca | modelo | kilometraje |
|---|---|---|
| Toyota | Corolla | 67921 |
| Nissan | Versa | 63456 |
| Nissan | Versa | 83456 |
| Honda | City | 49832 |
| Toyota | Corolla | 97921 |

---

### 4. Vehículos con kilometraje mayor a 5000 y menor a 65000

Incluye los datos de modelo, anio y kilometraje.

**Solución**

```sql
SELECT modelo, anio, kilometraje
  FROM Automovil
 WHERE kilometraje > 5000
   AND kilometraje < 65000;
```

**Salida**

| modelo | anio | kilometraje |
|---|---|---|
| Versa | 2024 | 43456 |
| City | 2025 | 9832 |
| Versa | 2023 | 63456 |
| City | 2024 | 19832 |
| Corolla | 2024 | 47921 |
| City | 2023 | 49832 |

---

### 5. Vehículos que corresponde verificación en septiembre-octubre

Incluye los datos de marca, municipio y placa.

Se toma el último dígito numérico de la placa (el que está antes de la letra final). Las placas terminadas en **3 o 4** corresponden a septiembre-octubre.

**Solución**

```sql
SELECT marca, municipio, placa
  FROM Automovil
 WHERE SUBSTRING(placa, CHAR_LENGTH(placa) - 1, 1) IN ('3', '4');
```

**Salida**

| marca | municipio | placa |
|---|---|---|
| Nissan | Pachuca | HJC123E |
| Honda | Tulancingo | HJC124E |
| Honda | Tulancingo | HJC133E |
| Toyota | Actopan | HJC133E |
| Nissan | Pachuca | HJC223E |
| Honda | Tulancingo | HJC223E |
| Toyota | Actopan | HJC223E |
