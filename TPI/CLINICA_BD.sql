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
ALTER TABLE Especialidad ADD Imagen_URL VARCHAR(255);

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
    Diagnostico VARCHAR(300),
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
    Fecha        DATE NOT NULL,
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

UPDATE Medico 
SET Imagen_URL = 'https://centromedicoabc.com/wp-content/uploads/2023/05/elegir-nutricionista-1.webp' 
WHERE Id_Especialidad = 1; -- Nutrición

UPDATE Especialidad 
SET Imagen_URL = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7AH8KsiMyBAZlm0T_VfORxLhNtFWvv8HtJc-MVAM6CpFb3oW7gvjc75O9&s=10' 
WHERE Id_Especialidad = 2; -- Psicología

UPDATE Medico 
SET Imagen_URL = 'https://i.pinimg.com/236x/bc/98/6c/bc986c077f35ccad9bcd07a7062b11b7.jpg' 
WHERE Id_Especialidad = 3; -- Médico Clínico

UPDATE Especialidad 
SET Imagen_URL = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ5dwEoEyzNQ9vs_YTVV4PqgDTB8E03K1Av--YswiGEnhc1iwf2y3fSDBI&s=10' 
WHERE Id_Especialidad = 4; -- Ginecología

UPDATE Especialidad 
SET Imagen_URL = 'https://s3.sa-east-1.amazonaws.com/doctoraliar.com/doctor/041352/041352c0784a6db1267757a25f4370ee_large.jpg' 
WHERE Id_Especialidad = 5; -- Dermatología

UPDATE Especialidad 
SET Imagen_URL = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRMdF9mJKd4_A8TKvdhzr5rDgpAHzkkkTBkuw7vS3kske1FanQGBMbA319&s=10' 
WHERE Id_Especialidad = 6; -- Pediatría
GO

UPDATE Especialidad 
SET Descripcion = 'Asesoramiento en alimentación saludable, dietas y buena relacion con las comidas.' 
WHERE Id_Especialidad = 1; -- Nutrición

UPDATE Especialidad 
SET Descripcion = 'Atención de la salud mental, tratamiento de ansiedad, depresión y acompañamiento terapéutico.' 
WHERE Id_Especialidad = 2; -- Psicología

UPDATE Especialidad 
SET Descripcion = 'Diagnóstico y tratamiento de enfermedades generales, controles de salud y derivaciones a especialistas.' 
WHERE Id_Especialidad = 3; -- Médico Clínico

UPDATE Especialidad 
SET Descripcion = 'Salud reproductiva femenina, controles ginecológicos, embarazo y seguimiento hormonal.' 
WHERE Id_Especialidad = 4; -- Ginecología

UPDATE Especialidad 
SET Descripcion = 'Diagnóstico y tratamiento de enfermedades de la piel, cabello y uñas. Control de lunares y tratamientos estéticos.' 
WHERE Id_Especialidad = 5; -- Dermatología

UPDATE Especialidad 
SET Descripcion = 'Atención médica integral para bebés, niños y adolescentes. Controles de crecimiento y vacunación.' 
WHERE Id_Especialidad = 6; -- Pediatría
GO

ALTER TABLE HorarioMedico
DROP COLUMN DiaSemana;

alter table HorarioMedico add Fecha Date not null

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
(2,'MP1001',1,'https://i.pinimg.com/236x/bc/98/6c/bc986c077f35ccad9bcd07a7062b11b7.jpg'),
(3,'MP1002',3,'https://i.pinimg.com/236x/bc/98/6c/bc986c077f35ccad9bcd07a7062b11b7.jpg');
GO

INSERT INTO Turno
(NumeroTurno, Fecha, HoraInicio, HoraFin, Observaciones, Diagnostico, FechaCreacion, FechaModificación, Estado, Id_Paciente, Id_Medico)
VALUES
('T0001','2026-06-20','09:00:00','09:30:00','Control anual','Paciente sano',GETDATE(),NULL,'Cerrado',1,1),
('T0002','2026-06-21','10:00:00','10:30:00','Dolor de cabeza','Tratamiento indicado',GETDATE(),NULL,'Atendido',2,2),
('T0003','2026-06-22','11:00:00','11:30:00','Consulta general','Pendiente',GETDATE(),NULL,'Nuevo',1,2);
GO

INSERT INTO HorarioMedico (Id_Medico, Fecha, HoraInicio, HoraFin)
VALUES
-- Médico 1
(1, '2026-07-01', '08:00:00', '08:30:00'),
(1, '2026-07-01', '08:30:00', '09:00:00'),
(1, '2026-07-01', '09:00:00', '09:30:00'),
(1, '2026-07-01', '09:30:00', '10:00:00'),
(1, '2026-07-02', '08:00:00', '08:30:00'),
(1, '2026-07-02', '08:30:00', '09:00:00'),
(1, '2026-07-02', '09:00:00', '09:30:00'),

-- Médico 2
(2, '2026-07-01', '14:00:00', '14:30:00'),
(2, '2026-07-01', '14:30:00', '15:00:00'),
(2, '2026-07-01', '15:00:00', '15:30:00'),
(2, '2026-07-03', '10:00:00', '10:30:00'),
(2, '2026-07-03', '10:30:00', '11:00:00'),
(2, '2026-07-03', '11:00:00', '11:30:00');

ALTER TABLE Turno
ALTER COLUMN Diagnostico VARCHAR(300) NULL;

ALTER TABLE Medico ADD Activo BIT NOT NULL DEFAULT 1;
ALTER TABLE Especialidad ADD Activo BIT NOT NULL DEFAULT 1;
ALTER TABLE Especialidad DROP COLUMN Imagen_URL;
SELECT * FROM Medico;
SELECT * FROM Rol;
SELECT * FROM Paciente;
SELECT * FROM Persona;
SELECT * FROM Perfil;
SELECT * FROM Empleado;
SELECT * FROM ObraSocial;
SELECT * FROM HorarioMedico;
Select * from turno;
select * from Especialidad;


select 
e.Id_Empleado,
e.Id_Persona,
p.Nombre,
p.Apellido,
pe.Id_Rol
from Empleado e
inner join Persona p on e.Id_Persona = p.Id_Persona
inner join Perfil pe on e.Id_Perfil = pe.Id_Perfil


select 
(p.Apellido +' '+ p.Nombre) as 'Nombre completo',
m.Id_Medico, m.Id_Persona
from Persona p
inner join Medico m on p.Id_Persona = m.Id_Persona

SELECT m.Id_Medico, m.Imagen_URL,
                           e.Id_Especialidad, e.Nombre_Especialidad, e.Descripcion
                    FROM Medico m
                    INNER JOIN Especialidad e ON m.Id_Especialidad = e.Id_Especialidad
                    WHERE m.Activo = 1 AND e.Activo = 1
                    AND m.Id_Medico = (
                        SELECT TOP 1 Id_Medico FROM Medico 
                        WHERE Id_Especialidad = e.Id_Especialidad AND Activo = 1)


select p.Id_Persona, p.Dni, p.Nombre, p.Apellido, p.Telefono, p.Email, p.Direccion, p.FechaNacimiento,  ob.Id_ObraSocial, ob.Nombre_ObraSocial
from Paciente pac
inner join Perfil perf on pac.Id_Perfil = perf.Id_Perfil
inner join Persona p on pac.Id_Persona = p.Id_Persona
inner join ObraSocial ob on pac.Id_ObraSocial = ob.Id_ObraSocial
    where perf.Id_Perfil = @id

    SELECT p.Id_Persona, p.Dni, p.Nombre, p.Apellido
FROM Paciente pac
INNER JOIN Persona p ON pac.Id_Persona = p.Id_Persona
WHERE
    (@dni = '' OR p.Dni LIKE @dni + '%')
    AND (@nombre = '' OR p.Nombre LIKE @nombre + '%')
    AND (@apellido = '' OR p.Apellido LIKE @apellido + '%')

select pac.Id_Paciente, p.Nombre, p.Apellido, p.DNI, ob.Id_ObraSocial, ob.Nombre_ObraSocial
from Paciente pac
inner join Persona p on pac.Id_Persona = p.Id_Persona
inner join ObraSocial ob on pac.Id_ObraSocial = ob.Id_ObraSocial
where p.Id_Persona = 1

select distinct hm.Fecha, m.Id_Medico
from HorarioMedico hm
inner join Medico m on hm.Id_Medico = m.Id_Medico
WHERE m.Id_Medico = @id

select HoraInicio 
from HorarioMedico
where Fecha = 2026-07-01