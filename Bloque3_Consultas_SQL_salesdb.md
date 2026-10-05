# Bloque 3. Consultas SQL nivel básico

## Instrucciones

Utilizar la base de datos `salesdb` para construir las consultas. Primero se construye la base de datos, las tablas y se insertan datos de prueba.

## Modelo relacional

| Tabla | Atributos | Claves foráneas |
|---|---|---|
| customers | customerID (PK), name, email | |
| addresses | addressID (PK), customerID, street, city, state, country, zipCode, addressType | customerID → customers |
| suppliers | supplierID (PK), name, contactEmail | |
| products | productID (PK), name, price, supplierID | supplierID → suppliers |
| orders | orderID (PK), customerID, orderDate | customerID → customers |
| orderDetails | orderDetailID (PK), orderID, productID, quantity, unitPrice | orderID → orders, productID → products |

## Creación de la base de datos, tablas y datos de prueba

```sql
CREATE DATABASE IF NOT EXISTS salesdb;
USE salesdb;

-- Se borran primero las tablas hijas por las claves foráneas
DROP TABLE IF EXISTS orderDetails;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS suppliers;
DROP TABLE IF EXISTS addresses;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customerID INT PRIMARY KEY,
    name       VARCHAR(60) NOT NULL,
    email      VARCHAR(80)
);

CREATE TABLE addresses (
    addressID   INT PRIMARY KEY,
    customerID  INT NOT NULL,
    street      VARCHAR(80),
    city        VARCHAR(50),
    state       VARCHAR(50),
    country     VARCHAR(50),
    zipCode     VARCHAR(10),
    addressType ENUM('Billing', 'Shipping') NOT NULL,
    FOREIGN KEY (customerID) REFERENCES customers(customerID)
);

CREATE TABLE suppliers (
    supplierID   INT PRIMARY KEY,
    name         VARCHAR(60) NOT NULL,
    contactEmail VARCHAR(80)
);

CREATE TABLE products (
    productID  INT PRIMARY KEY,
    name       VARCHAR(60) NOT NULL,
    price      DECIMAL(10,2) NOT NULL,
    supplierID INT NOT NULL,
    FOREIGN KEY (supplierID) REFERENCES suppliers(supplierID)
);

CREATE TABLE orders (
    orderID    INT PRIMARY KEY,
    customerID INT NOT NULL,
    orderDate  DATE NOT NULL,
    FOREIGN KEY (customerID) REFERENCES customers(customerID)
);

CREATE TABLE orderDetails (
    orderDetailID INT PRIMARY KEY,
    orderID       INT NOT NULL,
    productID     INT NOT NULL,
    quantity      INT NOT NULL,
    unitPrice     DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (orderID)   REFERENCES orders(orderID),
    FOREIGN KEY (productID) REFERENCES products(productID)
);

-- Datos de prueba
INSERT INTO customers VALUES
(1,  'Ana García',      'ana.garcia@mail.com'),
(2,  'Luis Martínez',   'luis.martinez@mail.com'),
(3,  'María López',     'maria.lopez@mail.com'),
(4,  'Carlos Sánchez',  'carlos.sanchez@mail.com'),
(5,  'Laura Fernández', 'laura.fernandez@mail.com'),
(6,  'Javier Torres',   'javier.torres@mail.com'),
(7,  'Sofía Ramírez',   'sofia.ramirez@mail.com'),
(8,  'Pedro Gómez',     'pedro.gomez@mail.com'),
(9,  'Elena Díaz',      'elena.diaz@mail.com'),
(10, 'Miguel Ruiz',     'miguel.ruiz@mail.com'),
(11, 'Carmen Vega',     'carmen.vega@mail.com'),
(12, 'Andrés Navarro',  'andres.navarro@mail.com');

INSERT INTO addresses VALUES
(1,  1,  'Calle Mayor 12',          'Madrid',                 'Madrid',    'España', '28013', 'Billing'),
(2,  1,  'Calle Mayor 12',          'Madrid',                 'Madrid',    'España', '28013', 'Shipping'),
(3,  2,  'Av. Diagonal 450',        'Barcelona',              'Cataluña',  'España', '08006', 'Billing'),
(4,  3,  'Calle Sierpes 8',         'Sevilla',                'Andalucía', 'España', '41004', 'Shipping'),
(5,  4,  'Gran Vía 25',             'Madrid',                 'Madrid',    'España', '28013', 'Shipping'),
(6,  5,  'Calle Colón 3',           'Valencia',               'Valencia',  'España', '46004', 'Billing'),
(7,  6,  'Paseo Independencia 10',  'Zaragoza',               'Aragón',    'España', '50004', 'Billing'),
(8,  7,  'Calle Alcalá 100',        'Madrid',                 'Madrid',    'España', '28009', 'Billing'),
(9,  8,  'Calle Larios 5',          'Málaga',                 'Andalucía', 'España', '29005', 'Shipping'),
(10, 9,  'Calle Fuencarral 60',     'Madrid',                 'Madrid',    'España', '28004', 'Billing'),
(11, 10, 'Rúa do Franco 15',        'Santiago de Compostela', 'Galicia',   'España', '15702', 'Shipping'),
(12, 10, 'Rúa do Franco 15',        'Santiago de Compostela', 'Galicia',   'España', '15702', 'Billing'),
(13, 11, 'Calle Betis 22',          'Sevilla',                'Andalucía', 'España', '41010', 'Billing'),
(14, 12, 'Calle Sierpes 40',        'Sevilla',                'Andalucía', 'España', '41004', 'Shipping');

INSERT INTO suppliers VALUES
(1, 'Tecnosur S.A.',        'ventas@tecnosur.com'),
(2, 'ElectroMundo',         'contacto@electromundo.com'),
(3, 'Distribuciones Alfa',  'info@dalfa.com'),
(4, 'Importadora Beta',     'ventas@ibeta.com'),
(5, 'Global Parts',         'sales@globalparts.com'),
(6, 'Casa del Hardware',    'hola@casahardware.com'),
(7, 'Alpha Supplies',       'info@alphasupplies.com');

INSERT INTO products VALUES
(1,  'Laptop 15"',            899.99, 1),
(2,  'Monitor 24"',           189.90, 2),
(3,  'Teclado mecánico',       79.50, 3),
(4,  'Mouse inalámbrico',      25.00, 3),
(5,  'Tablet 10"',            249.00, 1),
(6,  'Impresora láser',       320.00, 5),
(7,  'Disco SSD 1TB',         119.99, 6),
(8,  'Auriculares Bluetooth',  59.90, 2),
(9,  'Smartphone',            699.00, 4),
(10, 'Webcam HD',              45.00, 7);

INSERT INTO orders VALUES
(1,  1,  '2026-01-15'),
(2,  10, '2026-02-03'),
(3,  3,  '2026-02-20'),
(4,  10, '2026-03-11'),
(5,  5,  '2026-04-02'),
(6,  2,  '2026-05-19'),
(7,  7,  '2026-06-07'),
(8,  10, '2026-07-25'),
(9,  4,  '2026-08-14'),
(10, 8,  '2026-09-30');

INSERT INTO orderDetails VALUES
(1,  1,  1,  1, 899.99),
(2,  1,  4,  2,  25.00),
(3,  2,  3,  1,  79.50),
(4,  2,  8,  1,  59.90),
(5,  3,  5,  1, 249.00),
(6,  4,  2,  2, 189.90),
(7,  4,  10, 3,  45.00),
(8,  5,  7,  1, 119.99),
(9,  6,  9,  1, 699.00),
(10, 6,  4,  1,  25.00),
(11, 7,  6,  1, 320.00),
(12, 8,  1,  1, 899.99),
(13, 8,  3,  2,  79.50),
(14, 9,  8,  4,  59.90),
(15, 10, 2,  1, 189.90);
```

## Consultas

### 1. Listar todos los clientes

Obtén el customerID, nombre y email de todos los clientes.

**Solución ✅**

```sql
SELECT customerID, name, email
  FROM customers;
```

**Salida 📌**

| customerID | name | email |
|---|---|---|
| 1 | Ana García | ana.garcia@mail.com |
| 2 | Luis Martínez | luis.martinez@mail.com |
| 3 | María López | maria.lopez@mail.com |
| 4 | Carlos Sánchez | carlos.sanchez@mail.com |
| 5 | Laura Fernández | laura.fernandez@mail.com |
| 6 | Javier Torres | javier.torres@mail.com |
| 7 | Sofía Ramírez | sofia.ramirez@mail.com |
| 8 | Pedro Gómez | pedro.gomez@mail.com |
| 9 | Elena Díaz | elena.diaz@mail.com |
| 10 | Miguel Ruiz | miguel.ruiz@mail.com |
| 11 | Carmen Vega | carmen.vega@mail.com |
| 12 | Andrés Navarro | andres.navarro@mail.com |

### 2. Direcciones en una ciudad específica

Muestra todas las direcciones que estén en la ciudad de Madrid.

**Solución ✅**

```sql
SELECT *
  FROM addresses
 WHERE city = 'Madrid';
```

**Salida 📌**

| addressID | customerID | street | city | state | country | zipCode | addressType |
|---|---|---|---|---|---|---|---|
| 1 | 1 | Calle Mayor 12 | Madrid | Madrid | España | 28013 | Billing |
| 2 | 1 | Calle Mayor 12 | Madrid | Madrid | España | 28013 | Shipping |
| 5 | 4 | Gran Vía 25 | Madrid | Madrid | España | 28013 | Shipping |
| 8 | 7 | Calle Alcalá 100 | Madrid | Madrid | España | 28009 | Billing |
| 10 | 9 | Calle Fuencarral 60 | Madrid | Madrid | España | 28004 | Billing |

### 3. Productos con precio mayor a 200

Lista los productos cuyo precio sea mayor a 200.

**Solución ✅**

```sql
SELECT *
  FROM products
 WHERE price > 200;
```

**Salida 📌**

| productID | name | price | supplierID |
|---|---|---|---|
| 1 | Laptop 15" | 899.99 | 1 |
| 5 | Tablet 10" | 249.00 | 1 |
| 6 | Impresora láser | 320.00 | 5 |
| 9 | Smartphone | 699.00 | 4 |

### 4. Pedidos ordenados por fecha

Muestra todos los pedidos ordenados desde el más reciente al más antiguo.

**Solución ✅**

```sql
SELECT *
  FROM orders
 ORDER BY orderDate DESC;
```

**Salida 📌**

| orderID | customerID | orderDate |
|---|---|---|
| 10 | 8 | 2026-09-30 |
| 9 | 4 | 2026-08-14 |
| 8 | 10 | 2026-07-25 |
| 7 | 7 | 2026-06-07 |
| 6 | 2 | 2026-05-19 |
| 5 | 5 | 2026-04-02 |
| 4 | 10 | 2026-03-11 |
| 3 | 3 | 2026-02-20 |
| 2 | 10 | 2026-02-03 |
| 1 | 1 | 2026-01-15 |

### 5. Primeros 5 proveedores

Obtén los primeros 5 proveedores ordenados alfabéticamente por nombre.

**Solución ✅**

```sql
SELECT *
  FROM suppliers
 ORDER BY name ASC
 LIMIT 5;
```

**Salida 📌**

| supplierID | name | contactEmail |
|---|---|---|
| 7 | Alpha Supplies | info@alphasupplies.com |
| 6 | Casa del Hardware | hola@casahardware.com |
| 3 | Distribuciones Alfa | info@dalfa.com |
| 2 | ElectroMundo | contacto@electromundo.com |
| 5 | Global Parts | sales@globalparts.com |

### 6. Clientes y su ciudad

Muestra el nombre del cliente y la ciudad donde vive.

**Solución ✅**

```sql
SELECT c.name, a.city
  FROM customers c
  JOIN addresses a ON a.customerID = c.customerID;
```

**Salida 📌**

| name | city |
|---|---|
| Ana García | Madrid |
| Ana García | Madrid |
| Luis Martínez | Barcelona |
| María López | Sevilla |
| Carlos Sánchez | Madrid |
| Laura Fernández | Valencia |
| Javier Torres | Zaragoza |
| Sofía Ramírez | Madrid |
| Pedro Gómez | Málaga |
| Elena Díaz | Madrid |
| Miguel Ruiz | Santiago de Compostela |
| Miguel Ruiz | Santiago de Compostela |
| Carmen Vega | Sevilla |
| Andrés Navarro | Sevilla |

> Ana García y Miguel Ruiz aparecen dos veces porque tienen dos direcciones (Billing y Shipping).

### 7. Productos y su proveedor

Lista el nombre del producto y el nombre de su proveedor.

**Solución ✅**

```sql
SELECT p.name AS producto, s.name AS proveedor
  FROM products p
  JOIN suppliers s ON s.supplierID = p.supplierID;
```

**Salida 📌**

| producto | proveedor |
|---|---|
| Laptop 15" | Tecnosur S.A. |
| Monitor 24" | ElectroMundo |
| Teclado mecánico | Distribuciones Alfa |
| Mouse inalámbrico | Distribuciones Alfa |
| Tablet 10" | Tecnosur S.A. |
| Impresora láser | Global Parts |
| Disco SSD 1TB | Casa del Hardware |
| Auriculares Bluetooth | ElectroMundo |
| Smartphone | Importadora Beta |
| Webcam HD | Alpha Supplies |

### 8. Pedidos de un cliente específico

Muestra todos los pedidos realizados por el cliente con customerID = 10.

**Solución ✅**

```sql
SELECT *
  FROM orders
 WHERE customerID = 10;
```

**Salida 📌**

| orderID | customerID | orderDate |
|---|---|---|
| 2 | 10 | 2026-02-03 |
| 4 | 10 | 2026-03-11 |
| 8 | 10 | 2026-07-25 |

### 9. Cantidad de productos en cada pedido

Muestra el ID del pedido y la cantidad de productos comprados en cada uno.

**Solución ✅**

```sql
SELECT orderID, SUM(quantity) AS cantidadProductos
  FROM orderDetails
 GROUP BY orderID;
```

**Salida 📌**

| orderID | cantidadProductos |
|---|---|
| 1 | 3 |
| 2 | 2 |
| 3 | 1 |
| 4 | 5 |
| 5 | 1 |
| 6 | 2 |
| 7 | 1 |
| 8 | 3 |
| 9 | 4 |
| 10 | 1 |

### 10. Clientes con dirección de envío

Lista los clientes que tienen una dirección de tipo Shipping.

**Solución ✅**

```sql
SELECT DISTINCT c.customerID, c.name, c.email
  FROM customers c
  JOIN addresses a ON a.customerID = c.customerID
 WHERE a.addressType = 'Shipping';
```

**Salida 📌**

| customerID | name | email |
|---|---|---|
| 1 | Ana García | ana.garcia@mail.com |
| 3 | María López | maria.lopez@mail.com |
| 4 | Carlos Sánchez | carlos.sanchez@mail.com |
| 8 | Pedro Gómez | pedro.gomez@mail.com |
| 10 | Miguel Ruiz | miguel.ruiz@mail.com |
| 12 | Andrés Navarro | andres.navarro@mail.com |
