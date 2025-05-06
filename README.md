# Conquiscamp.API

**Conquiscamp.API** es una API para gestionar el puntaje de clubes durante eventos de campamento. Está construida con una arquitectura en capas (N-Capas) que sigue los principios de separación de responsabilidades y buenas prácticas de desarrollo.

## Estructura del Proyecto

El proyecto está dividido en varias capas, cada una con una responsabilidad específica:
Conquiscamp.API/                    # Capa de presentación (API)
│
├── Controllers/                    # Controladores REST (EndPoints)
│   ├── AuthController.cs           # Controlador de autenticación (JWT)
│   ├── EventController.cs          # Controlador para gestión de eventos
│   └── ScoreController.cs          # Controlador para puntajes de clubes
│
├── Middleware/                     # Middleware global
│   ├── ExceptionHandlingMiddleware.cs   # Manejo de excepciones global
│   ├── JWTAuthenticationMiddleware.cs   # Middleware de autenticación JWT
│   └── LoggingMiddleware.cs        # Middleware para logs personalizados
│
├── Program.cs                      # Configuración inicial de la API
└── Startup.cs                      # Configuración de servicios y middleware

Conquiscamp.Application/            # Capa de lógica de negocio
│
├── Services/                       # Implementación de la lógica del negocio
│   ├── AuthService.cs              # Lógica de autenticación JWT
│   ├── EventService.cs             # Lógica relacionada a eventos
│   └── ScoreService.cs             # Cálculo de puntajes
│
├── Interfaces/                     # Interfaces para los servicios
│   ├── IAuthService.cs
│   ├── IEventService.cs
│   └── IScoreService.cs

Conquiscamp.Domain/                # Capa de dominio (núcleo del negocio)
│
├── Entities/                       # Entidades del dominio
│   ├── Club.cs
│   ├── Event.cs
│   └── Score.cs
│
├── ValueObjects/                   # Objetos de valor
│   ├── Email.cs
│   └── Name.cs
│
├── Interfaces/                     # Interfaces de repositorio
│   ├── IClubRepository.cs
│   ├── IEventRepository.cs
│   └── IScoreRepository.cs

Conquiscamp.Persistence.Sql/        # Capa de persistencia (EF Core, SQL Server)
│
├── DbContext/
│   ├── ApplicationDbContext.cs     # Contexto principal de EF Core
│   └── Configuration.cs            # Configuraciones específicas
│
├── Migrations/                     # Migraciones de base de datos
│   ├── 20230420120000_InitialCreate.cs
│   └── 20230420130000_AddScoreTable.cs
│
├── Repositories/                   # Implementaciones de los repositorios
│   ├── ClubRepository.cs
│   ├── EventRepository.cs
│   └── ScoreRepository.cs

Conquiscamp.Infrastructure/         # Capa de infraestructura (servicios externos)
│
├── Email/
│   ├── IEmailService.cs
│   └── EmailService.cs
│
├── MongoLogging/
│   ├── IMongoLogger.cs
│   └── MongoLogger.cs
│
├── RedisCache/
│   ├── ICacheService.cs
│   └── RedisCacheService.cs

Conquiscamp.Shared/                 # Capa compartida (común para todos los proyectos)
│
├── DTOs/
│   ├── ClubDto.cs
│   ├── EventDto.cs
│   └── ScoreDto.cs
│
├── Results/
│   ├── ApiResponse.cs
│   └── ErrorResult.cs
│
├── Claims/
│   ├── RoleClaims.cs
│   └── PermissionClaims.cs
│
├── Helpers/
│   ├── JwtHelper.cs
│   └── LoggingHelper.cs
│
└── .env                            # Variables de entorno (configuración segura)

### Capa de Presentación (API)

Esta capa contiene todos los controladores REST que exponen los endpoints de la API.

- **Controllers/**
  - `AuthController.cs`: Controlador de autenticación utilizando JWT.
  - `EventController.cs`: Controlador para la gestión de eventos.
  - `ScoreController.cs`: Controlador para puntajes de clubes.

- **Middleware/**
  - `ExceptionHandlingMiddleware.cs`: Middleware para manejar excepciones globalmente.
  - `JWTAuthenticationMiddleware.cs`: Middleware para la autenticación JWT.
  - `LoggingMiddleware.cs`: Middleware para registrar logs personalizados.

- **Program.cs**: Configuración inicial de la API.
- **Startup.cs**: Configuración de servicios y middleware.

### Capa de Lógica de Negocio (Application)

En esta capa se implementan los servicios que contienen la lógica de negocio y las interfaces que los definen.

- **Services/**
  - `EventService.cs`: Lógica de negocio relacionada con eventos.
  - `ScoreService.cs`: Lógica para calcular los puntajes.
  - `AuthService.cs`: Lógica de autenticación JWT.

- **Interfaces/**
  - `IEventService.cs`: Interface para `EventService`.
  - `IScoreService.cs`: Interface para `ScoreService`.
  - `IAuthService.cs`: Interface para `AuthService`.

### Capa de Dominio (Domain)

Aquí se definen las entidades del negocio y las reglas de negocio, además de los objetos de valor.

- **Entities/**
  - `Club.cs`: Modelo de Club.
  - `Event.cs`: Modelo de Evento.
  - `Score.cs`: Modelo de Puntaje.

- **ValueObjects/**
  - `Email.cs`: Objeto de valor para el email.
  - `Name.cs`: Objeto de valor para el nombre.

- **Interfaces/**
  - `IEventRepository.cs`: Interface para el repositorio de eventos.
  - `IScoreRepository.cs`: Interface para el repositorio de puntajes.
  - `IClubRepository.cs`: Interface para el repositorio de clubes.

### Capa de Persistencia (Persistence)

Esta capa es responsable de interactuar con la base de datos SQL. Utiliza Entity Framework Core para manejar las operaciones de persistencia.

- **DbContext/**
  - `ApplicationDbContext.cs`: Configuración del DbContext para SQL Server.
  - `Configuration.cs`: Configuración específica de EF Core.

- **Migrations/**
  - `20230420120000_InitialCreate.cs`: Migración inicial de la base de datos.
  - `20230420130000_AddScoreTable.cs`: Migración para agregar la tabla de puntajes.

- **Repositories/**
  - `EventRepository.cs`: Repositorio para acceder a datos de eventos.
  - `ScoreRepository.cs`: Repositorio para acceder a datos de puntajes.
  - `ClubRepository.cs`: Repositorio para acceder a datos de clubes.

### Capa de Infraestructura (Infrastructure)

Esta capa integra servicios externos como correo electrónico, logging, y caché.

- **Email/**
  - `IEmailService.cs`: Interface para el servicio de correo electrónico.
  - `EmailService.cs`: Implementación del servicio de correo electrónico.

- **MongoLogging/**
  - `IMongoLogger.cs`: Interface para el logger en MongoDB.
  - `MongoLogger.cs`: Implementación del logger para MongoDB.

- **RedisCache/**
  - `ICacheService.cs`: Interface para el servicio de caché.
  - `RedisCacheService.cs`: Implementación del servicio de caché en Redis.

### Capa Compartida (Shared)

Esta capa contiene clases y utilidades comunes, como los DTOs (Data Transfer Objects) y otras clases auxiliares.

- **DTOs/**
  - `EventDto.cs`: DTO para la entidad Evento.
  - `ScoreDto.cs`: DTO para la entidad Puntaje.
  - `ClubDto.cs`: DTO para la entidad Club.

- **Results/**
  - `ApiResponse.cs`: Clase base para respuestas de la API.
  - `ErrorResult.cs`: Resultado de error para la API.

- **Claims/**
  - `RoleClaims.cs`: Definición de roles (Admin, User, etc.).
  - `PermissionClaims.cs`: Definición de permisos a nivel de API.

- **Helpers/**
  - `JwtHelper.cs`: Ayuda para generar y validar JWT.
  - `LoggingHelper.cs`: Ayuda para registrar logs estructurados. 
