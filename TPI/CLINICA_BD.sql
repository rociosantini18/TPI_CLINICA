CREATE DATABASE CLINICA;
GO

USE CLINICA;
GO

CREATE TABLE Perfil (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL
);
GO

CREATE TABLE Usuario (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Dni VARCHAR(20) NOT NULL UNIQUE,
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NOT NULL,
    Email VARCHAR(150) NOT NULL UNIQUE,
    Telefono VARCHAR(30),
    Direccion VARCHAR(200),
    Contrasena VARCHAR(255) NOT NULL,
    FechaNacimiento DATE NOT NULL,
    IdPerfil INT NOT NULL,
    Activo BIT NOT NULL DEFAULT 1,

    CONSTRAINT FK_Usuario_Perfil FOREIGN KEY (IdPerfil) REFERENCES Perfil(Id)
);
GO


SELECT * FROM Usuario

INSERT INTO Perfil (Nombre)
VALUES
('Administrador'),
('Cliente'),
('Empleado');

INSERT INTO Usuario
(Dni, Nombre, Apellido, Email, Telefono, Direccion, Contrasena, FechaNacimiento, IdPerfil, Activo)
VALUES
('30111222', 'Juan', 'Pérez', 'juan.perez@mail.com', '1122334455',
 'Av. Rivadavia 1234', '1234', '1990-03-15', 1, 1),

('28999888', 'María', 'Gómez', 'maria.gomez@mail.com', '1166778899',
 'San Martín 456', '1234', '1988-07-21', 2, 1),

('33444555', 'Carlos', 'López', 'carlos.lopez@mail.com', '1155667788',
 'Belgrano 789', '1234', '1995-11-10', 3, 1),

('35777888', 'Ana', 'Fernández', 'ana.fernandez@mail.com', '1144556677',
 'Mitre 321', '1234', '1998-02-28', 3, 1),

('27888999', 'Luis', 'Martínez', 'luis.martinez@mail.com', '1133445566',
 'Sarmiento 654', '1234', '1985-09-05', 2, 1),

('39999111', 'Sofía', 'Rodríguez', 'sofia.rodriguez@mail.com', '1177889900',
 'Lavalle 987', '1234', '2000-12-12', 3, 1),

('26666111', 'Pedro', 'Sánchez', 'pedro.sanchez@mail.com', '1199001122',
 'Corrientes 111', '1234', '1982-06-30', 2, 0),

('32222333', 'Lucía', 'Ramírez', 'lucia.ramirez@mail.com', '1166112233',
 'Moreno 222', '1234', '1993-08-18', 3, 1),

('31111444', 'Diego', 'Torres', 'diego.torres@mail.com', '1144778899',
 'Callao 333', '1234', '1991-04-22', 1, 1),

('34444555', 'Valentina', 'Castro', 'valentina.castro@mail.com', '1133557799',
 'Pueyrredón 444', '1234', '1997-10-07', 3, 1);