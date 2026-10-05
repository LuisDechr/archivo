# B5. Práctica 0. Biblioteca
## Las 12 reglas de las bases de datos distribuidas

**Nombre:** _(tu nombre)_
**Grupo / Materia:** _(grupo y materia)_
**Fecha:** 5 de octubre de 2026

---

## Introducción

Una base de datos distribuida (BDD) es un conjunto de datos relacionados lógicamente que están almacenados en varios sitios (computadoras) conectados por una red, pero que el usuario percibe como una sola base de datos. C. J. Date formuló doce reglas (más una regla fundamental, la "regla 0") que describen las características que debe tener un sistema de bases de datos distribuidas ideal.

## Regla fundamental (regla 0)

**Un sistema distribuido debe parecerle al usuario exactamente igual que un sistema no distribuido.**
El usuario no debe notar que los datos están repartidos en distintos sitios. Las 12 reglas siguientes son consecuencias de este principio.

## Las 12 reglas

### 1. Autonomía local
Cada sitio es independiente: administra sus propios datos, seguridad, integridad y operaciones locales sin depender de otros sitios. Las operaciones locales se resuelven localmente.

### 2. No dependencia de un sitio central
Ningún sitio debe ser indispensable para el funcionamiento del resto. No existe un servidor maestro cuya falla detenga todo el sistema; con ello se evitan cuellos de botella y puntos únicos de falla.

### 3. Operación continua
El sistema no debe detenerse por tareas planeadas como agregar o quitar un sitio, respaldos o cambios de configuración. Debe haber disponibilidad permanente.

### 4. Independencia de localización
(También llamada transparencia de ubicación). El usuario no necesita saber en qué sitio están físicamente los datos; los consulta como si estuvieran todos en un mismo lugar, y los datos pueden cambiar de sitio sin afectar a las aplicaciones.

### 5. Independencia de fragmentación
Una tabla puede dividirse en fragmentos (horizontal, vertical o mixta) y guardarse en distintos sitios. El usuario ve la tabla completa, como si no estuviera fragmentada.

### 6. Independencia de replicación
Los datos pueden copiarse (replicarse) en varios sitios para mejorar el rendimiento y la disponibilidad. El usuario no debe percibir las réplicas, y el sistema es quien las mantiene consistentes.

### 7. Procesamiento distribuido de consultas
El sistema debe optimizar las consultas que involucran datos de varios sitios, eligiendo la estrategia de menor costo (reduciendo la transferencia de datos por la red y aprovechando el procesamiento paralelo).

### 8. Gestión de transacciones distribuidas
El sistema debe mantener las propiedades ACID (atomicidad, consistencia, aislamiento y durabilidad) en transacciones que abarcan varios sitios, usando mecanismos como el control de concurrencia distribuido, la recuperación ante fallas y el protocolo de confirmación en dos fases (2PC).

### 9. Independencia del hardware
El sistema debe funcionar en equipos de distintos fabricantes y plataformas de hardware, tratándolos como un conjunto homogéneo.

### 10. Independencia del sistema operativo
El sistema debe poder ejecutarse sobre diferentes sistemas operativos en los distintos sitios (por ejemplo Windows, Linux o UNIX).

### 11. Independencia de la red
El sistema debe funcionar sin importar el tipo de red o protocolos de comunicación que conecten los sitios.

### 12. Independencia del DBMS
Los sitios pueden usar distintos manejadores de bases de datos (por ejemplo Oracle, MySQL o SQL Server), siempre que soporten una interfaz común; el sistema debe integrarlos como uno solo.

## Tabla resumen

| # | Regla | Idea principal |
|---|-------|----------------|
| 0 | Regla fundamental | Parece un sistema no distribuido |
| 1 | Autonomía local | Cada sitio se administra solo |
| 2 | Sin sitio central | Ningún sitio es indispensable |
| 3 | Operación continua | Sin paros por mantenimiento |
| 4 | Independencia de localización | No importa dónde están los datos |
| 5 | Independencia de fragmentación | Los fragmentos son invisibles al usuario |
| 6 | Independencia de replicación | Las réplicas son invisibles al usuario |
| 7 | Consultas distribuidas | Optimización global de consultas |
| 8 | Transacciones distribuidas | ACID en varios sitios |
| 9 | Independencia del hardware | Cualquier equipo |
| 10 | Independencia del SO | Cualquier sistema operativo |
| 11 | Independencia de la red | Cualquier red |
| 12 | Independencia del DBMS | Cualquier manejador compatible |

## Conclusión

_(Escribe aquí 3 o 4 líneas con tus propias palabras: por qué son importantes estas reglas y cuáles te parecen más difíciles de cumplir en la práctica, por ejemplo la gestión de transacciones distribuidas o la independencia del DBMS.)_

## Bibliografía

> Completa con el libro que realmente consultaste en la biblioteca (autor, título, edición, editorial, año, páginas).

- Date, C. J. *An Introduction to Database Systems* (capítulo sobre bases de datos distribuidas / sistemas cliente-servidor y distribuidos).
- _(Otro libro o fuente consultada en la biblioteca)_
