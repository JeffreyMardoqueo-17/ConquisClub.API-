CREATE DATABASE ConquisAPI;
GO
USE ConquisAPI
GO

----------------TABLAS  => 21 tablas
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
    NombreCompleto VARCHAR(100) NOT NULL ,
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

CREATE TABLE SancionClub (
    Id INT PRIMARY KEY IDENTITY(1,1),
    IdClub INT NOT NULL FOREIGN KEY REFERENCES Club(Id),
    Motivo TEXT NOT NULL,
    FechaInicio DATE NOT NULL DEFAULT GETDATE(),
    FechaFin DATE NOT NULL, -- hasta qué fecha aplica la sanción
    FueCumplida BIT DEFAULT 0 -- para saber si ya se cumplió la sanción
);


GO
CREATE TABLE MiembroClub(
    Id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(100) NOT NULL,
    FechaNacimiento DATE NOT NULL, ---esto es para que automaticamete se cambie la edad 
    Genero VARCHAR(25) NOT NULL,---Se llenara con un select 
    IdRol INT NOT NULL FOREIGN KEY REFERENCES Rol(Id),
    EsBautizado BOOLEAN,    
    IdClub INT NOT NULL FOREIGN KEY REFERENCES Club(Id)
);

GO
CREATE TABLE HistorialEstadoMiembro(
    Id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    IdMiembroClub INT NOT NULL FOREIGN KEY REFERENCES MiembroClub(Id),
    EstadoAnterior VARCHAR(50), 
    EstadoNuevo VARCHAR(50), 
    Motivo VARCHAR(MAX) NOT NULL,
    Fecha DATETIME DEFAULT GETDATE()
);
GO 
CREATE TABLE Evento (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(100) NOT NULL,
    TipoEvento VARCHAR(50) NOT NULL, -- Campamento, Caminata, Concurso, etc.
    Descripcion TEXT,
    FechaInicio DATE NOT NULL,
    FechaFin DATE NOT NULL,
    FechaLimiteInscripcion DATE NOT NULL, -- Nueva columna para controlar inscripciones tardías
    Direccion VARCHAR(200),
    Latitud DECIMAL(9,6),
    Longitud DECIMAL(9,6),
    CupoMaximo INT, -- Opcional: para limitar cantidad de clubes
    IdAsociacion INT NOT NULL FOREIGN KEY REFERENCES Asociacion(Id),
    IdAdministrador INT NOT NULL FOREIGN KEY REFERENCES Administrador(Id)
);
GO
CREATE TABLE InscripcionEvento (
    Id INT PRIMARY KEY IDENTITY(1,1),
    IdEvento INT NOT NULL FOREIGN KEY REFERENCES Evento(Id),
    IdClub INT NOT NULL FOREIGN KEY REFERENCES Club(Id),
    FechaInscripcion DATETIME DEFAULT GETDATE(),
    Estado VARCHAR(50) DEFAULT 'Inscrito', -- Inscrito, Cancelado, Pendiente
    EsInscripcionTardia BIT, -- se llenara con un trigger
    PosicionInscripcion INT, -- lo vy calcular con un trigger o en el backend
    CONSTRAINT UQ_Club_Evento UNIQUE (IdEvento, IdClub) -- Evita inscripción duplicada
);
GO

-- CATEGORÍAS DE ACTIVIDADES
CREATE TABLE CategoriaActividad (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(100),
    Descripcion TEXT
);
GO

-- ACTIVIDADES
CREATE TABLE Actividad (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(100),
    Descripcion TEXT,
    Fecha DATE,
    HoraInicio TIME,
    HoraFin TIME,
    SoloNinas BIT DEFAULT 0,
    SoloVarones BIT DEFAULT 0,
    IdEvento INT NOT NULL FOREIGN KEY REFERENCES Evento(Id),
    IdCategoria INT NOT NULL FOREIGN KEY REFERENCES CategoriaActividad(Id)
);
GO

-- REGLAS POR ACTIVIDAD
CREATE TABLE ReglaActividad (
    Id INT PRIMARY KEY IDENTITY(1,1),
    IdActividad INT NOT NULL FOREIGN KEY REFERENCES Actividad(Id),
    Descripcion TEXT,
    PuntajeMaximo INT
);
GO

-- PARTICIPACIONES
CREATE TABLE Participacion (
    Id INT PRIMARY KEY IDENTITY(1,1),
    IdActividad INT NOT NULL FOREIGN KEY REFERENCES Actividad(Id),
    IdClub INT NOT NULL FOREIGN KEY REFERENCES Club(Id),
    PuntajeObtenido INT,
    Observaciones TEXT
);
GO

-- PARTICIPANTES DE UNA ACTIVIDAD
CREATE TABLE ParticipanteActividad (
    Id INT PRIMARY KEY IDENTITY(1,1),
    IdParticipacion INT NOT NULL FOREIGN KEY REFERENCES Participacion(Id),
    IdMiembroClub INT NOT NULL FOREIGN KEY REFERENCES MiembroClub(Id)
);
GO

-- PENALIZACIONES
CREATE TABLE Penalizacion (
    Id INT PRIMARY KEY IDENTITY(1,1),
    IdClub INT NOT NULL FOREIGN KEY REFERENCES Club(Id),
    IdEvento INT NOT NULL FOREIGN KEY REFERENCES Evento(Id),
    Motivo TEXT,
    Detalle TEXT,
    Fecha DATE,
    VisibleSoloAlClub BIT DEFAULT 0
);
GO

-- ESTADÍSTICAS DE CLUBES
CREATE TABLE EstadisticaClub (
    Id INT PRIMARY KEY IDENTITY(1,1),
    IdClub INT NOT NULL FOREIGN KEY REFERENCES Club(Id),
    EventosParticipados INT DEFAULT 0,
    PuntajeTotal INT DEFAULT 0,
    ActividadesGanadas INT DEFAULT 0,
    PenalizacionesTotales INT DEFAULT 0
);
GO

-- UBICACIONES DE EVENTOS
CREATE TABLE UbicacionEvento (
    Id INT PRIMARY KEY IDENTITY(1,1),
    IdEvento INT NOT NULL FOREIGN KEY REFERENCES Evento(Id),
    NombreLugar VARCHAR(100),
    Descripcion TEXT,
    Latitud DECIMAL(9,6),
    Longitud DECIMAL(9,6)
);
GO

-- COMENTARIOS SOBRE EVENTOS
CREATE TABLE ComentarioEvento (
    Id INT PRIMARY KEY IDENTITY(1,1),
    IdEvento INT NOT NULL FOREIGN KEY REFERENCES Evento(Id),
    IdClub INT NOT NULL FOREIGN KEY REFERENCES Club(Id),
    Comentario TEXT,
    Fecha DATE DEFAULT GETDATE()
);
GO

-- HISTORIAL DE ACCESO DE CLUB
CREATE TABLE HistorialAccesoClub (
    Id INT PRIMARY KEY IDENTITY(1,1),
    IdClub INT NOT NULL FOREIGN KEY REFERENCES Club(Id),
    FechaInicioSesion DATETIME,
    DuracionSesion TIME,
    PropiedadIntelectual TEXT
);
GO