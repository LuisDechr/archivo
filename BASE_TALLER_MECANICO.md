# Reporte de Base de Datos: Taller Mecánico

**Materia:** Bases de Datos
**Alumno:** (tu nombre completo)
**Semestre y grupo:** 6to Semestre, Grupo 2
**Fecha:** Octubre 2026

---

## 1. Introducción

En este reporte explico cómo diseñé una base de datos para un taller mecánico. Con ella se puede llevar el control de los clientes, sus autos, los mecánicos, los servicios que se hacen y los pagos.

Para armarla usé normalización, así los datos no se repiten y se evitan errores al guardarlos:

- **1FN:** cada campo guarda un solo dato. Por ejemplo, el nombre y el teléfono del cliente van en campos separados.
- **2FN:** todos los campos dependen de la llave primaria completa.
- **3FN:** ningún campo que no es llave depende de otro que tampoco es llave. Por eso los datos del cliente están en su propia tabla y no se repiten en cada auto.

---

## 2. Desarrollo

### 2.1 Entidades

Las entidades que identifiqué son: Cliente, Auto, Mecánico, Servicio y Pago.

### 2.2 Relaciones (cardinalidad)

- Un cliente puede tener varios autos (1:N).
- Un auto puede tener varios servicios (1:N).
- Un mecánico realiza varios servicios (1:N).
- Un servicio tiene un solo pago (1:1).

### 2.3 Diagrama entidad-relación

*(Aquí va la imagen de tu diagrama. Ejemplo: `![Diagrama ER](diagrama.png)`)*

### 2.4 Modelo relacional

Al pasar el diagrama entidad-relación a tablas, cada entidad se convierte en una relación (tabla). Las llaves primarias (PK) van marcadas con `#` y las llaves foráneas (FK) con `*`.

```
CLIENTE  (#id_cliente, nombre, apellido, telefono, correo)

AUTO     (#id_auto, marca, modelo, anio, placas, *id_cliente)
           id_cliente  → CLIENTE(id_cliente)

MECANICO (#id_mecanico, nombre, apellido, especialidad, sueldo)

SERVICIO (#id_servicio, *id_auto, *id_mecanico, fecha_ingreso, fecha_entrega,
          descripcion, costo, estatus)
           id_auto     → AUTO(id_auto)
           id_mecanico → MECANICO(id_mecanico)

PAGO     (#id_pago, *id_servicio, fecha_pago, monto, metodo_pago)
           id_servicio → SERVICIO(id_servicio)   [único: un pago por servicio]
```

Resumen de las llaves:

| Tabla | Llave primaria | Llaves foráneas |
|-------|----------------|-----------------|
| cliente | id_cliente | — |
| auto | id_auto | id_cliente |
| mecanico | id_mecanico | — |
| servicio | id_servicio | id_auto, id_mecanico |
| pago | id_pago | id_servicio |

### 2.5 Creación de tablas (DDL)

```sql
CREATE DATABASE IF NOT EXISTS taller_mecanico;
USE taller_mecanico;

CREATE TABLE cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    telefono VARCHAR(15),
    correo VARCHAR(100)
);

CREATE TABLE auto (
    id_auto INT AUTO_INCREMENT PRIMARY KEY,
    marca VARCHAR(30) NOT NULL,
    modelo VARCHAR(30) NOT NULL,
    anio INT NOT NULL,
    placas VARCHAR(10) UNIQUE NOT NULL,
    id_cliente INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE mecanico (
    id_mecanico INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    especialidad VARCHAR(40),
    sueldo DECIMAL(10,2) NOT NULL
);

CREATE TABLE servicio (
    id_servicio INT AUTO_INCREMENT PRIMARY KEY,
    id_auto INT NOT NULL,
    id_mecanico INT NOT NULL,
    fecha_ingreso DATE NOT NULL,
    fecha_entrega DATE,
    descripcion TEXT NOT NULL,
    costo DECIMAL(10,2) NOT NULL,
    estatus VARCHAR(20) DEFAULT 'En proceso',
    FOREIGN KEY (id_auto) REFERENCES auto(id_auto),
    FOREIGN KEY (id_mecanico) REFERENCES mecanico(id_mecanico)
);

CREATE TABLE pago (
    id_pago INT AUTO_INCREMENT PRIMARY KEY,
    id_servicio INT UNIQUE NOT NULL,
    fecha_pago DATE NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    metodo_pago VARCHAR(20) NOT NULL,
    FOREIGN KEY (id_servicio) REFERENCES servicio(id_servicio)
);
```

### 2.6 Inserción de datos (DML)

```sql
INSERT INTO cliente (nombre, apellido, telefono, correo) VALUES
('Javier', 'Torres', '7711112233', 'javier.torres@email.com'),
('Daniela', 'Moreno', '7714445566', 'daniela.moreno@email.com'),
('Ricardo', 'Pérez', '7717778899', 'ricardo.perez@email.com');

INSERT INTO auto (marca, modelo, anio, placas, id_cliente) VALUES
('Nissan', 'Versa', 2017, 'HGO-101-A', 1),
('Volkswagen', 'Jetta', 2019, 'HGO-202-B', 2),
('Chevrolet', 'Spark', 2016, 'HGO-303-C', 3);

INSERT INTO mecanico (nombre, apellido, especialidad, sueldo) VALUES
('Armando', 'Ruiz', 'Frenos y suspensión', 11500.00),
('Fernando', 'Castillo', 'Motor', 13000.00),
('Omar', 'Lara', 'Sistema eléctrico', 12000.00);

INSERT INTO servicio (id_auto, id_mecanico, fecha_ingreso, fecha_entrega, descripcion, costo, estatus) VALUES
(1, 1, '2026-10-01', '2026-10-02', 'Cambio de balatas y rectificado de discos', 1800.00, 'Entregado'),
(2, 2, '2026-10-02', '2026-10-05', 'Cambio de banda de distribución', 3200.00, 'Entregado'),
(3, 3, '2026-10-05', '2026-10-06', 'Cambio de batería y revisión del alternador', 2100.00, 'Entregado');

INSERT INTO pago (id_servicio, fecha_pago, monto, metodo_pago) VALUES
(1, '2026-10-02', 1800.00, 'Efectivo'),
(2, '2026-10-05', 3200.00, 'Tarjeta'),
(3, '2026-10-06', 2100.00, 'Transferencia');
```

### 2.7 Consultas

**1. ¿Cuántos autos se repararon la primera semana de octubre?**

```sql
SELECT COUNT(*) AS autos_reparados
FROM servicio
WHERE estatus = 'Entregado'
  AND fecha_entrega BETWEEN '2026-10-01' AND '2026-10-07';
```

**2. ¿Cuánto dinero ingresó hoy?**

```sql
SELECT COALESCE(SUM(monto), 0) AS ingreso_hoy
FROM pago
WHERE fecha_pago = CURDATE();
```

**3. ¿Qué mecánico reparó más autos en el mes?**

```sql
SELECT m.nombre, m.apellido, COUNT(s.id_servicio) AS total_autos
FROM mecanico m
JOIN servicio s ON m.id_mecanico = s.id_mecanico
WHERE s.estatus = 'Entregado'
  AND MONTH(s.fecha_entrega) = MONTH(CURDATE())
  AND YEAR(s.fecha_entrega) = YEAR(CURDATE())
GROUP BY m.id_mecanico, m.nombre, m.apellido
ORDER BY total_autos DESC
LIMIT 1;
```

---

## 3. Conclusión

Con este trabajo entendí que normalizar antes de crear las tablas ayuda a que la base de datos quede ordenada y sin información repetida. También practiqué cómo se relacionan las tablas con llaves primarias y foráneas, y cómo con consultas SQL se pueden contestar preguntas del taller, como cuántos autos se repararon, cuánto se ganó en el día y qué mecánico trabajó más.
