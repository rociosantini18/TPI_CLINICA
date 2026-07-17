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
    Descripcion VARCHAR(200),
    Activo BIT NOT NULL DEFAULT 1
);
GO

CREATE TABLE ObraSocial (
    Id_ObraSocial INT IDENTITY(1,1) PRIMARY KEY,
    Nombre_ObraSocial VARCHAR(100) NOT NULL,
    Activo BIT NOT NULL DEFAULT 1
);
GO

CREATE TABLE Medico (
    Id_Medico INT IDENTITY(1,1) PRIMARY KEY,
    Id_Persona INT NOT NULL,
    Matricula VARCHAR (20) NOT NULL,
    Id_Especialidad INT NOT NULL,
    Imagen_URL VARCHAR(200) NOT NULL,
    Id_Perfil INT NOT NULL UNIQUE,
    Activo BIT NOT NULL DEFAULT 1
    FOREIGN KEY (Id_Perfil) REFERENCES Perfil(Id_Perfil),
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
    Diagnostico VARCHAR(300) NULL,
    FechaCreacion DATE NOT NULL,
    FechaModificación DATE,
    Estado VARCHAR(50),
    Id_Paciente INT NOT NULL,
    Id_Medico INT NOT NULL,
    Id_Especialidad INT NOT NULL,
    FOREIGN KEY (Id_Paciente) REFERENCES Paciente(Id_Paciente),
    FOREIGN KEY (Id_Medico) REFERENCES Medico(Id_Medico),
    FOREIGN KEY (Id_Especialidad) REFERENCES Especialidad(Id_Especialidad)
);
GO

CREATE TABLE HorarioMedico (
    Id_Horario   INT IDENTITY(1,1) PRIMARY KEY,
    Id_Medico    INT NOT NULL,
    HoraInicio   TIME NOT NULL,
    HoraFin      TIME NOT NULL,
    DiaSemana INT NOT NULL DEFAULT 1,
    FOREIGN KEY (Id_Medico) REFERENCES Medico(Id_Medico)
);
GO

CREATE TABLE MedicoDiaAtencion (
    Id_Medico INT FOREIGN KEY REFERENCES Medico(Id_Medico),
    DiaSemana INT NOT NULL,
    PRIMARY KEY (Id_Medico, DiaSemana)
);
GO

CREATE TABLE MedicoEspecialidad(
    Id_MedicoEspecialidad int identity(1,1) primary key,
    Id_Medico int not null,
    Id_Especialidad int not null,
    Estado bit not null
FOREIGN KEY (Id_Especialidad) REFERENCES Especialidad(Id_Especialidad),
FOREIGN KEY (Id_Medico) REFERENCES Medico(Id_Medico)
)

-- ROLES
INSERT INTO Rol (NombreRol) VALUES
('Administrador'),
('Recepcionista'),
('Cliente'),
('Medico');

-- ESPECIALIDADES
INSERT INTO Especialidad (Nombre_Especialidad, Descripcion, Activo) VALUES
('Cardiología','Especialista en corazón',1),
('Pediatría','Atención infantil',1),
('Clínica Médica','Medicina general',1),
('Traumatología','Huesos y articulaciones',1),
('Dermatología','Piel',1);

-- OBRAS SOCIALES
INSERT INTO ObraSocial (Nombre_ObraSocial, Activo) VALUES
('OSDE',1),
('Swiss Medical',1),
('Galeno',1),
('IOMA',1),
('PAMI',1);

-- PERSONAS
INSERT INTO Persona (Dni,Nombre,Apellido,Email,Telefono,Direccion,FechaNacimiento) VALUES
('30111222','Juan','Perez','juan@gmail.com','111111111','San Fernando','1985-04-15'),
('28999888','Maria','Gomez','maria@gmail.com','222222222','Tigre','1982-06-10'),
('40123456','Lucas','Fernandez','lucas@gmail.com','333333333','San Isidro','2001-02-20'),
('42345678','Sofia','Lopez','sofia@gmail.com','444444444','Vicente Lopez','2003-09-12'),
('35678901','Carlos','Martinez','carlos@gmail.com','555555555','San Martin','1992-11-01'),
('37890123','Valentina','Diaz','vale@gmail.com','666666666','Olivos','1996-01-28');

-- PERFILES
INSERT INTO Perfil (Id_Rol,NombreUsuario,Contraseña,Activo) VALUES
(2,'jperez','1234',1),
(2,'mgomez','1234',1),
(3,'lfernandez','1234',1),
(3,'slopez','1234',1),
(4,'cmartinez','1234',1),
(1,'admin','admin',1);

-- MEDICOS
INSERT INTO Medico (Id_Persona,Matricula,Id_Especialidad,Imagen_URL,Id_Perfil,Activo) VALUES
(1,'MAT1001',1,'/Imagenes/medico1.png',1,1),
(2,'MAT1002',2,'/Imagenes/medico2.png',2,1);

-- PACIENTES
INSERT INTO Paciente (Id_Persona,Id_ObraSocial,Id_Perfil) VALUES
(3,1,3),
(4,2,4);

-- EMPLEADOS
INSERT INTO Empleado (Id_Persona,Id_Perfil) VALUES
(5,5);

-- HORARIOS MEDICOS
INSERT INTO HorarioMedico (Id_Medico,HoraInicio,HoraFin,DiaSemana) VALUES
(1,'08:00','12:00',1),
(1,'08:00','12:00',3),
(2,'14:00','18:00',2),
(2,'14:00','18:00',4);

-- DIAS DE ATENCION
INSERT INTO MedicoDiaAtencion (Id_Medico,DiaSemana) VALUES
(1,1),
(1,3),
(2,2),
(2,4);

-- MEDICO ESPECIALIDAD
INSERT INTO MedicoEspecialidad (Id_Medico,Id_Especialidad,Estado) VALUES
(1,1,1),
(2,2,1);

-- TURNOS
INSERT INTO Turno
(NumeroTurno,Fecha,HoraInicio,HoraFin,Observaciones,Diagnostico,FechaCreacion,FechaModificación,Estado,Id_Paciente,Id_Medico,Id_Especialidad)
VALUES
('T0001','2026-07-20','08:00','08:30','Control anual','Paciente estable','2026-07-17','2026-07-17','Finalizado',1,1,1),

('T0002','2026-07-20','08:30','09:00','Dolor de pecho',NULL,'2026-07-17',NULL,'Pendiente',2,1,1),

('T0003','2026-07-21','14:00','14:30','Control pediátrico','Resfrío común','2026-07-17','2026-07-17','Finalizado',1,2,2),

('T0004','2026-07-22','14:30','15:00','Vacunación',NULL,'2026-07-17',NULL,'Pendiente',2,2,2);