CREATE DATABASE ConquisAPI;
GO
USE ConquisAPI
GO

----------------TABLAS 
CREATE TABLE Asociacion(
    Id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(100) NOT NULL
);
GO 
CREATE TABLE Departamento(
    Id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(50) NOT NULL,
    IdAsociacion INT NOT NULL FOREIGN KEY REFERENCES Asociacion(Id)
);
GO
CREATE TABLE Cargo(
    Id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(100) NOT NULL----aqui iran para los miembros de adminsitradores y dentro del club, los que estan dentro del club seran: Director, subdirector, tesorero, secretario, Solo integrante
);
GO
CREATE TABLE Rol(
    Id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(100) NOT NULL --------aventurero, guia mayor, conquistador
);
GO
CREATE TABLE Administrador(
    Id INT NOT NULL PRIMARY KEY  IDENTITY(1,1),
    NombreCompleto VARCHAR(100),
    IdCargo INT NOT NULL FOREIGN KEY REFERENCES Cargo(Id), ---Director, coordinador de clubes, etc
    Correo VARCHAR(50) NOT NULL,
    Clave VARCHAR(Max) NOT NULL, ----Maximo por que se encriptara la contra
    IdAsociacion INT NOT NULL FOREIGN KEY REFERENCES Asociacion(Id)
);
GO
CREATE TABLE Club(
    Id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(100), --EJEMPLI: Sear-Jasub
    Descripcion VARCHAR(MAX),--- ESTO ES OPCIONAL
    NumIntegrantes INT, ----esto va a quedar vacio y se ira sumando cuando el director del club agregue miembros
    CantidadMasculinos INT, ----cuando se agregue los miembros se agregara el sexo aqui tambien todos los varones
    CantidadFemeninos INT, ------cuando se agregue los miembros se agregara el sexo aqui tambien todas las hembras BIGINT
    NombreUsuario VARCHAR(100),--- para el acceso, sera el mismo nombre del club BIGINT
    ClaveClub VARCHAR(MAX),-- LA CONNTRASEÑA para igresar, esto se encriptara y sera minimo BIGINT
    IdAsociacion INT NOT NULL FOREIGN KEY REFERENCES Asociacion(Id) ----para saber a que asociacion pertenece este club
);

GO
CREATE TABLE MiembroClub(
    Id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(100) NOT NULL,
    FechaNacimiento DATE NOT NULL, ---esto es para que automaticamete se cambie la edad 
    Edad INT, ----Esta quedara vacia, y este no podra editalro el que regsitre, solo aparecera despues de ingresar la fechaa de nacimeinto 
    Genero VARCHAR(25) NOT NULL,---Se llenara con un select 
    IdRol INT NOT NULL FOREIGN KEY REFERENCES Rol(Id),
    EsBautizado BOOLEAN,    
);
