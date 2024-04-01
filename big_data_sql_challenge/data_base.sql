DROP DATABASE IF EXISTS colegio ;
CREATE DATABASE colegio;
USE colegio ;

CREATE TABLE genero (
    id_genero INT PRIMARY KEY,
    genero VARCHAR(255)
);

CREATE TABLE nivel (
    id_nivel INT PRIMARY KEY,
    nivel VARCHAR(255)
);


CREATE TABLE instructor (
    id_instructor INT PRIMARY KEY,
    apellido_instructor VARCHAR(255),
    nombre_instructor VARCHAR(255),
    email_instructor VARCHAR(255)
);


CREATE TABLE alumno (
    id_alumno INT PRIMARY KEY,
    nombre VARCHAR(255),
    apellido VARCHAR(255),
    email VARCHAR(255),
    nota_1p INT,
    nota_2p INT,
    nota_final INT,
    id_genero INT
    );

CREATE TABLE modelado (
    legajo INT PRIMARY KEY,
    id_nivel INT,
    id_alumno INT,
    id_instructor INT

);




ALTER TABLE alumno
    ADD CONSTRAINT fk_alumno_genero FOREIGN KEY (id_genero) REFERENCES genero(id_genero);




ALTER TABLE modelado    
    ADD CONSTRAINT fk_modelado_instructor FOREIGN KEY (id_instructor) REFERENCES instructor(id_instructor);
ALTER TABLE modelado
    ADD CONSTRAINT fk_modelado_nivel FOREIGN KEY (id_level) REFERENCES nivel(id_level);
ALTER TABLE modelado
    ADD CONSTRAINT fk_modelado_alumno FOREIGN KEY (id_alumno) REFERENCES alumno(id_alumno);
