DROP DATABASE IF EXISTS SISTEMA_CALIFICACIONES;

CREATE DATABASE SISTEMA_CALIFICACIONES;

USE SISTEMA_CALIFICACIONES;

CREATE TABLE profesor (
    id_profesor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(40) NOT NULL,
    apellido VARCHAR(40) NOT NULL,
    correo VARCHAR(100) NOT NULL
);

CREATE TABLE alumnos (
    id_alumno INT AUTO_INCREMENT PRIMARY KEY,
    matricula VARCHAR(40) NOT NULL UNIQUE,
    nombre VARCHAR(40) NOT NULL,
    apellido VARCHAR(40) NOT NULL,
    correo VARCHAR(100) NOT NULL
);

CREATE TABLE materias (
    id_materia INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(40) NOT NULL,
    creditos INT NOT NULL
);

CREATE TABLE grupos (
    id_grupo INT AUTO_INCREMENT PRIMARY KEY,
    id_profesor INT NOT NULL,
    id_materia INT NOT NULL,

    FOREIGN KEY (id_profesor)
        REFERENCES profesor(id_profesor),

    FOREIGN KEY (id_materia)
        REFERENCES materias(id_materia)
);

CREATE TABLE inscripcion (
    id_inscripcion INT AUTO_INCREMENT PRIMARY KEY,
    id_alumno INT NOT NULL,
    id_grupo INT NOT NULL,

    FOREIGN KEY (id_alumno)
        REFERENCES alumnos(id_alumno),

    FOREIGN KEY (id_grupo)
        REFERENCES grupos(id_grupo),

    UNIQUE (id_alumno, id_grupo)
);

CREATE TABLE calificacion (
    id_calificacion INT AUTO_INCREMENT PRIMARY KEY,
    id_inscripcion INT NOT NULL,
    unidad INT NOT NULL,
    calificacion DECIMAL(5,2) NOT NULL,

    FOREIGN KEY (id_inscripcion)
        REFERENCES inscripcion(id_inscripcion)
);

INSERT INTO profesor (nombre, apellido, correo) VALUES
('Juan', 'Pérez', 'juan.perez@gmail.com'),
('María', 'García', 'maria.garcia@gmail.com'),
('Carlos', 'López', 'carlos.lopez@gmail.com'),
('Ana', 'Martínez', 'ana.martinez@gmail.com'),
('Luis', 'Hernández', 'luis.hernandez@gmail.com');

INSERT INTO alumnos (matricula, nombre, apellido, correo) VALUES
('2026001', 'Pedro', 'Ramírez', 'pedro.ramirez@gmail.com'),
('2026002', 'Sofía', 'Torres', 'sofia.torres@gmail.com'),
('2026003', 'Diego', 'Morales', 'diego.morales@gmail.com'),
('2026004', 'Valeria', 'Cruz', 'valeria.cruz@gmail.com'),
('2026005', 'Miguel', 'Flores', 'miguel.flores@gmail.com');

INSERT INTO materias (nombre, creditos) VALUES
('Programación', 8),
('Bases de Datos', 8),
('Redes', 7),
('Matemáticas', 6),
('Ingeniería de Software', 8);

INSERT INTO grupos (id_profesor, id_materia) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO inscripcion (id_alumno, id_grupo) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO calificacion (id_inscripcion, unidad, calificacion) VALUES
(1, 1, 9.00),
(2, 1, 8.50),
(3, 1, 9.50),
(4, 1, 8.00),
(5, 1, 9.00);

SELECT * FROM profesor;

SELECT * FROM alumnos;

SELECT * FROM materias;

SELECT * FROM grupos;

SELECT * FROM inscripcion;

SELECT * FROM calificacion;
