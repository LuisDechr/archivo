CREATE DATABASE SistemaEscolar;

USE SistemaEscola;


CREATE TABLE Carrera (
    id_carrera INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL
);


CREATE TABLE Edificio (
    id_edificio INT PRIMARY KEY AUTO_INCREMENT,
    edificio VARCHAR(100) NOT NULL
);


CREATE TABLE Grupo (
    id_grupo INT PRIMARY KEY AUTO_INCREMENT,
    semestre INT NOT NULL,
    numero VARCHAR(10) NOT NULL,
    id_carrera INT NOT NULL,

    FOREIGN KEY (id_carrera)
        REFERENCES Carrera(id_carrera)
);


CREATE TABLE Profesor (
    id_profesor INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL
);


CREATE TABLE Materia (
    id_materia INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL
);


CREATE TABLE Aula (
    id_aula INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    id_edificio INT NOT NULL,

    FOREIGN KEY (id_edificio)
        REFERENCES Edificio(id_edificio)
);


CREATE TABLE Horario (
    id_horario INT NOT NULL AUTO_INCREMENT,
    id_aula INT NOT NULL,
    dia VARCHAR(15) NOT NULL,
    hora TIME NOT NULL,

    PRIMARY KEY (id_horario, id_aula),

    FOREIGN KEY (id_aula)
        REFERENCES Aula(id_aula)
);

CREATE TABLE Cursa (
    id_grupo INT NOT NULL,
    id_materia INT NOT NULL,

    PRIMARY KEY (id_grupo, id_materia),

    FOREIGN KEY (id_grupo)
        REFERENCES Grupo(id_grupo),

    FOREIGN KEY (id_materia)
        REFERENCES Materia(id_materia)
);


CREATE TABLE Imparte (
    id_profesor INT NOT NULL,
    id_materia INT NOT NULL,
    id_horario INT NOT NULL,
    id_aula INT NOT NULL,

    PRIMARY KEY (id_profesor, id_materia, id_horario, id_aula),

    FOREIGN KEY (id_profesor)
        REFERENCES Profesor(id_profesor),

    FOREIGN KEY (id_materia)
        REFERENCES Materia(id_materia),

    FOREIGN KEY (id_horario, id_aula)
        REFERENCES Horario(id_horario, id_aula)
);


INSERT INTO Carrera (nombre) VALUES
('Ciencias Computacionales'),
('Ingeniería en Sistemas'),
('Ingeniería Industrial'),
('Administración'),
('Contaduría');


INSERT INTO Edificio (edificio) VALUES
('Edificio A'),
('Edificio B'),
('Edificio C'),
('Edificio D'),
('Edificio E');



INSERT INTO Grupo (semestre, numero, id_carrera) VALUES
(1, '101', 1),
(2, '201', 1),
(3, '301', 2),
(4, '401', 3),
(5, '501', 4);



INSERT INTO Profesor (nombre) VALUES
('Juan Pérez'),
('María López'),
('Carlos Hernández'),
('Ana Martínez'),
('Luis García');



INSERT INTO Materia (nombre) VALUES
('Programación'),
('Bases de Datos'),
('Redes de Computadoras'),
('Matemáticas'),
('Ingeniería de Software');



INSERT INTO Aula (nombre, id_edificio) VALUES
('Aula 101', 1),
('Aula 102', 1),
('Aula 201', 2),
('Aula 202', 2),
('Laboratorio 301', 3);


INSERT INTO Horario (id_aula, dia, hora) VALUES
(1, 'Lunes', '08:00:00'),
(2, 'Martes', '10:00:00'),
(3, 'Miércoles', '12:00:00'),
(4, 'Jueves', '14:00:00'),
(5, 'Viernes', '16:00:00');



INSERT INTO Cursa (id_grupo, id_materia) VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 4),
(4, 5);



INSERT INTO Imparte
(id_profesor, id_materia, id_horario, id_aula)
VALUES
(1, 1, 1, 1),
(2, 2, 2, 2),
(3, 3, 3, 3),
(4, 4, 4, 4),
(5, 5, 5, 5);
