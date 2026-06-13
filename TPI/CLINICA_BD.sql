CREATE DATABASE CLINICA;
GO

USE CLINICA;
GO

CREATE TABLE Persona (
    Id_Persona INT IDENTITY(1,1) PRIMARY KEY,
    Dni VARCHAR(20) NOT NULL UNIQUE,
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NOT NULL,
    Email VARCHAR(150) NOT NULL UNIQUE,
    Telefono VARCHAR(30),
    Direccion VARCHAR(200),
    FechaNacimiento DATE NOT NULL,
);
GO

CREATE TABLE Rol (
    Id_Rol INT IDENTITY(1,1) PRIMARY KEY,
    NombreRol VARCHAR(100) NOT NULL
);
GO


CREATE TABLE Perfil (
    Id_Perfil INT IDENTITY(1,1) PRIMARY KEY,
    Id_Rol INT NOT NULL,
    NombreUsuario VARCHAR(50) NOT NULL UNIQUE,
    Contraseña VARCHAR(50) NOT NULL,
    Activo bit NOT NULL,
    FOREIGN KEY (Id_Rol) REFERENCES Rol(Id_Rol)
);
GO

CREATE TABLE Especialidad (
    Id_Especialidad INT IDENTITY(1,1) PRIMARY KEY,
    Nombre_Especialidad VARCHAR(100),
    Descripcion VARCHAR(200)
);
GO

CREATE TABLE ObraSocial (
    Id_ObraSocial INT IDENTITY(1,1) PRIMARY KEY,
    Nombre_ObraSocial VARCHAR(100) NOT NULL,
);GO

CREATE TABLE Medico (
    Id_Medico INT IDENTITY(1,1) PRIMARY KEY,
    Id_Persona INT NOT NULL,
    Matricula VARCHAR (20) NOT NULL,
    Id_Especialidad INT NOT NULL,
    Imagen_URL VARCHAR(200) NOT NULL,
    FOREIGN KEY (Id_Persona) REFERENCES Persona(Id_Persona),
    FOREIGN KEY (Id_Especialidad) REFERENCES Especialidad(Id_Especialidad)
);
GO

CREATE TABLE Paciente (
    Id_Paciente INT IDENTITY (1,1) PRIMARY KEY,
    Id_Persona INT NOT NULL,
    Id_ObraSocial INT NULL,
    Id_Perfil INT NOT NULL,
    FOREIGN KEY (Id_Persona) REFERENCES Persona(Id_Persona),
    FOREIGN KEY (Id_ObraSocial) REFERENCES ObraSocial(Id_ObraSocial),
    FOREIGN KEY (Id_Perfil) REFERENCES Perfil(Id_Perfil)
);
GO

CREATE TABLE Empleado (
    Id_Empleado INT IDENTITY (1,1) PRIMARY KEY,
    Id_Persona INT NOT NULL,
    Id_Perfil INT NOT NULL,
    FOREIGN KEY (Id_Persona) REFERENCES Persona(Id_Persona),
    FOREIGN KEY (Id_Perfil) REFERENCES Perfil(Id_Perfil)
);GO

CREATE TABLE Turno (
    Id_Turno INT IDENTITY (1,1) PRIMARY KEY,
    NumeroTurno VARCHAR(100) NOT NULL,
    Fecha DATE NOT NULL,
    HoraInicio TIME NOT NULL,
    HoraFin TIME NOT NULL,
    Observaciones VARCHAR(300),
    Diagnostico VARCHAR(300) NOT NULL,
    FechaCreacion DATE NOT NULL,
    FechaModificación DATE,
    Estado VARCHAR(50),
    Id_Paciente INT NOT NULL,
    Id_Medico INT NOT NULL,
    FOREIGN KEY (Id_Paciente) REFERENCES Paciente(Id_Paciente),
    FOREIGN KEY (Id_Medico) REFERENCES Medico(Id_Medico)
);
GO

SELECT * FROM Persona
SELECT * FROM Rol
SELECT * FROM Perfil


--INSERCION DE DATOS

--ROLES
INSERT INTO Rol(NombreRol)
VALUES
('Administrador'),
('Cliente'),
('Recepcionista');

--ESPECIALIDADES
INSERT INTO Especialidad(Nombre_Especialidad)
VALUES
('Nutrición'),
('Psicología'),
('Médico Clinico'),
('Ginecología'),
('Dermatología'),
('Pediatría');

--OBRAS SOCIALES
INSERT INTO ObraSocial(Nombre_ObraSocial)
VALUES
('Swiss Medical'),
('Premedic'),
('Osde'),
('IOMA'),
('Galeno');

--PERSONA
INSERT INTO Persona (Dni, Nombre, Apellido, Email, Telefono, Direccion, FechaNacimiento)
VALUES
('30111222','Juan','Perez','juan.perez@gmail.com','1122334455','Av. Rivadavia 100','1985-05-10'),
('32444555','Maria','Gomez','maria.gomez@gmail.com','1133445566','Av. Santa Fe 200','1990-08-15'),
('28999888','Carlos','Lopez','carlos.lopez@gmail.com','1144556677','Belgrano 300','1980-03-22'),
('35666777','Ana','Fernandez','ana.fernandez@gmail.com','1155667788','Corrientes 400','1995-12-01'),
('37777888','Pedro','Martinez','pedro.martinez@gmail.com','1166778899','Callao 500','1998-07-18');

--PERFIL
INSERT INTO Perfil (Id_Rol, NombreUsuario, Contraseña, Activo)
VALUES
(1,'admin','Admin123',1),
(2,'recepcion','Recep123',1),
(3,'juanp','Paciente123',1),
(3,'anaf','Paciente456',1);

--PACIENTE
INSERT INTO Paciente (Id_Persona, Id_ObraSocial, Id_Perfil)
VALUES
(1,1,3),
(4,2,4);

--MEDICO
INSERT INTO Medico (Id_Persona, Matricula, Id_Especialidad, Imagen_URL)
VALUES
(2,'MP1001',1,'doctor1.jpg'),
(3,'MP1002',3,'doctor2.jpg');

--EMPLEADO
INSERT INTO Empleado (Id_Persona, Id_Perfil)
VALUES
(5,1),
(2,2);

--TURNO
INSERT INTO Turno (NumeroTurno, Fecha, HoraInicio, HoraFin, Observaciones, Diagnostico, FechaCreacion, FechaModificación, Estado, Id_Paciente, Id_Medico)
VALUES
('T0001','2026-06-20','09:00:00','09:30:00','Control anual','Paciente sano',GETDATE(),NULL,'Cerrado',1,1),
('T0002','2026-06-21','10:00:00','10:30:00','Dolor de pecho','Estudios complementarios',GETDATE(),NULL,'Nuevo',2,2),
('T0003','2026-06-22','11:00:00','11:30:00','Control pediátrico','Pendiente',GETDATE(),NULL,'Reprogramado',1,1);
