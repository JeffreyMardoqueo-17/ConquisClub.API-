# Conquiscamp.API

**Conquiscamp.API** es una API para gestionar el puntaje de clubes durante eventos de campamento. Está construida con una arquitectura en capas (N-Capas) que sigue los principios de separación de responsabilidades y buenas prácticas de desarrollo.

## Estructura del Proyecto

El proyecto está dividido en varias capas, cada una con una responsabilidad específica:
✅ REFERENCIAS ENTRE PROYECTOS (.csproj)
📁 Conquiscamp.API/
➡️ Debe referenciar a:

Conquiscamp.Application

Conquiscamp.Shared

(opcional) Conquiscamp.Infrastructure si usas middlewares de logging, JWT helpers, etc.

xml
Copy
Edit
<ProjectReference Include="..\Conquiscamp.Application\Conquiscamp.Application.csproj" />
<ProjectReference Include="..\Conquiscamp.Shared\Conquiscamp.Shared.csproj" />
<!-- Opcional si usas helpers/middleware de Infrastructure -->
<ProjectReference Include="..\Conquiscamp.Infrastructure\Conquiscamp.Infrastructure.csproj" />
📁 Conquiscamp.Application/
➡️ Debe referenciar a:

Conquiscamp.Domain

Conquiscamp.Shared

xml
Copy
Edit
<ProjectReference Include="..\Conquiscamp.Domain\Conquiscamp.Domain.csproj" />
<ProjectReference Include="..\Conquiscamp.Shared\Conquiscamp.Shared.csproj" />
📁 Conquiscamp.Domain/
➡️ No debe referenciar a ningún otro proyecto.

Es la capa núcleo e independiente.

xml
Copy
Edit
<!-- No hay referencias en este .csproj -->
📁 Conquiscamp.Persistence.Sql/
➡️ Debe referenciar a:

Conquiscamp.Domain (para implementar interfaces de repositorio)

Conquiscamp.Shared (si usa DTOs, helpers, etc.)

xml
Copy
Edit
<ProjectReference Include="..\Conquiscamp.Domain\Conquiscamp.Domain.csproj" />
<ProjectReference Include="..\Conquiscamp.Shared\Conquiscamp.Shared.csproj" />
📁 Conquiscamp.Infrastructure/
➡️ Debe referenciar a:

Conquiscamp.Domain (para implementar interfaces como IEmailService, ICacheService)

Conquiscamp.Shared (para helpers, resultados, etc.)

xml
Copy
Edit
<ProjectReference Include="..\Conquiscamp.Domain\Conquiscamp.Domain.csproj" />
<ProjectReference Include="..\Conquiscamp.Shared\Conquiscamp.Shared.csproj" />
📁 Conquiscamp.Shared/
➡️ No debe referenciar a ningún otro proyecto.

Es una capa de utilidades reutilizables.

xml
Copy
Edit
<!-- No hay referencias -->
🧩 Diagrama Final de Referencias (Simplificado)
css
Copy
Edit
            [ Shared ]
               ▲   ▲   ▲   ▲
               │   │   │   │
          [Infrastructure] [Persistence.Sql]
               ▲       ▲
               └───────┤
                       │
                 [Application]
                       ▲
                       │
                     [API]

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
