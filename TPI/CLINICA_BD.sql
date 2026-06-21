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
    FechaNacimiento DATE NOT NULL
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
    Nombre_ObraSocial VARCHAR(100) NOT NULL
);
GO

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
    Id_Persona INT NOT NULL UNIQUE,
    Id_ObraSocial INT NULL,
    Id_Perfil INT NOT NULL UNIQUE,
    FOREIGN KEY (Id_Persona) REFERENCES Persona(Id_Persona),
    FOREIGN KEY (Id_ObraSocial) REFERENCES ObraSocial(Id_ObraSocial),
    FOREIGN KEY (Id_Perfil) REFERENCES Perfil(Id_Perfil)
);
GO

CREATE TABLE Empleado (
    Id_Empleado INT IDENTITY (1,1) PRIMARY KEY,
    Id_Persona INT NOT NULL UNIQUE,
    Id_Perfil INT NOT NULL UNIQUE,
    FOREIGN KEY (Id_Persona) REFERENCES Persona(Id_Persona),
    FOREIGN KEY (Id_Perfil) REFERENCES Perfil(Id_Perfil)
);
GO

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

CREATE TABLE HorarioMedico (
    Id_Horario   INT IDENTITY(1,1) PRIMARY KEY,
    Id_Medico    INT NOT NULL,
    DiaSemana    int NOT NULL,
    HoraInicio   TIME NOT NULL,
    HoraFin      TIME NOT NULL,
    FOREIGN KEY (Id_Medico) REFERENCES Medico(Id_Medico)
);
GO


INSERT INTO Rol(NombreRol)
VALUES
('Administrador'),
('Recepcionista'),
('Cliente');
GO

INSERT INTO Especialidad(Nombre_Especialidad)
VALUES
('Nutrición'),
('Psicología'),
('Médico Clinico'),
('Ginecología'),
('Dermatología'),
('Pediatría');
GO

INSERT INTO ObraSocial(Nombre_ObraSocial)
VALUES
('Swiss Medical'),
('Premedic'),
('Osde'),
('IOMA'),
('Galeno');
GO

INSERT INTO Persona (Dni, Nombre, Apellido, Email, Telefono, Direccion, FechaNacimiento)
VALUES
('30111222','Juan','Perez','juan.perez@gmail.com','1122334455','Av. Rivadavia 100','1985-05-10'), -- Paciente
('32444555','Maria','Gomez','maria.gomez@gmail.com','1133445566','Av. Santa Fe 200','1990-08-15'), -- Médico
('28999888','Carlos','Lopez','carlos.lopez@gmail.com','1144556677','Belgrano 300','1980-03-22'), -- Médico
('35666777','Ana','Fernandez','ana.fernandez@gmail.com','1155667788','Corrientes 400','1995-12-01'), -- Paciente
('37777888','Pedro','Martinez','pedro.martinez@gmail.com','1166778899','Callao 500','1998-07-18'), -- Administrador
('38888999','Laura','Sanchez','laura.sanchez@gmail.com','1177889900','Lavalle 600','1992-11-20'); -- Recepcionista
GO

INSERT INTO Perfil (Id_Rol, NombreUsuario, Contraseña, Activo)
VALUES
(3, 'juanperez', '1234', 1),    --Cliente
(3, 'anafernandez', '1234', 1), --Cliente
(1, 'pedrom', 'admin123', 1),   --Administrador
(2, 'lauras', 'recep123', 1);   --Recepcionista
GO

INSERT INTO Paciente (Id_Persona, Id_ObraSocial, Id_Perfil)
VALUES
(1,1,1),
(4,2,2);
GO

INSERT INTO Empleado (Id_Persona, Id_Perfil)
VALUES
(5, 3),
(6, 4);
GO

INSERT INTO Medico (Id_Persona, Matricula, Id_Especialidad, Imagen_URL)
VALUES
(2,'MP1001',1,'doctor1.jpg'),
(3,'MP1002',3,'doctor2.jpg');
GO

INSERT INTO Turno
(NumeroTurno, Fecha, HoraInicio, HoraFin, Observaciones, Diagnostico, FechaCreacion, FechaModificación, Estado, Id_Paciente, Id_Medico)
VALUES
('T0001','2026-06-20','09:00:00','09:30:00','Control anual','Paciente sano',GETDATE(),NULL,'Cerrado',1,1),
('T0002','2026-06-21','10:00:00','10:30:00','Dolor de cabeza','Tratamiento indicado',GETDATE(),NULL,'Atendido',2,2),
('T0003','2026-06-22','11:00:00','11:30:00','Consulta general','Pendiente',GETDATE(),NULL,'Nuevo',1,2);
GO

SELECT * FROM Medico;
SELECT * FROM Persona;
SELECT * FROM Rol;
SELECT * FROM Perfil;
SELECT * FROM Empleado;
SELECT * FROM ObraSocial;
SELECT * FROM Paciente;
SELECT * FROM HorarioMedico;

select 
(p.Apellido +' '+ p.Nombre) as 'Nombre completo',
m.Id_Medico, m.Id_Persona
from Persona p
inner join Medico m on p.Id_Persona = m.Id_Persona
