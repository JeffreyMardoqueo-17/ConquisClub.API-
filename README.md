Conquiscamp.API/                    # Capa de presentación (API)
│
├── Controllers/                     # Controladores REST (EndPoints)
│   ├── AuthController.cs            # Controlador de autenticación (JWT)
│   ├── EventController.cs           # Controlador para gestión de eventos
│   └── ScoreController.cs           # Controlador para puntajes de clubes
│
├── Middleware/                      # Middleware global
│   ├── ExceptionHandlingMiddleware.cs # Manejo de excepciones global
│   ├── JWTAuthenticationMiddleware.cs # Middleware de JWT
│   └── LoggingMiddleware.cs         # Middleware para logs personalizados
│
├── Program.cs                       # Configuración inicial de la API
└── Startup.cs                       # Configuración de servicios y middleware
│
Conquiscamp.Application/              # Capa de lógica de negocio
│
├── Services/                        # Servicios que implementan la lógica del negocio
│   ├── EventService.cs              # Lógica de negocios relacionada a eventos
│   ├── ScoreService.cs              # Lógica para calcular puntajes
│   └── AuthService.cs               # Lógica de autenticación JWT
│
├── Interfaces/                      # Interfaces para servicios e implementaciones
│   ├── IEventService.cs             # Interface para EventService
│   ├── IScoreService.cs             # Interface para ScoreService
│   └── IAuthService.cs              # Interface para AuthService
│
Conquiscamp.Domain/                  # Capa de dominio (Entidades y reglas de negocio)
│
├── Entities/                        # Entidades de negocio (modelos de datos)
│   ├── Club.cs                     # Modelo de Club
│   ├── Event.cs                    # Modelo de Evento
│   └── Score.cs                    # Modelo de Puntaje
│
├── ValueObjects/                    # Objetos de valor (No contienen lógica de negocio compleja)
│   ├── Email.cs                    # Objeto de valor para el email
│   └── Name.cs                     # Objeto de valor para el nombre
│
├── Interfaces/                      # Interfaces del dominio (repositorios)
│   ├── IEventRepository.cs          # Interface del repositorio para eventos
│   ├── IScoreRepository.cs          # Interface del repositorio para puntajes
│   └── IClubRepository.cs           # Interface del repositorio para clubes
│
Conquiscamp.Persistence.Sql/          # Capa de persistencia (Base de datos SQL)
│
├── DbContext/                       # Contiene la configuración de la base de datos
│   ├── ApplicationDbContext.cs      # DbContext para SQL Server (configuración general)
│   └── Configuration.cs             # Configuraciones específicas de EF Core
│
├── Migrations/                      # Migraciones de base de datos
│   ├── 20230420120000_InitialCreate.cs # Primera migración de base de datos
│   └── 20230420130000_AddScoreTable.cs # Migración para la tabla de puntajes
│
├── Repositories/                    # Implementación de los repositorios de base de datos
│   ├── EventRepository.cs           # Repositorio para acceso a datos de eventos
│   ├── ScoreRepository.cs           # Repositorio para acceso a datos de puntajes
│   └── ClubRepository.cs            # Repositorio para acceso a datos de clubes
│
Conquiscamp.Infrastructure/           # Capa de infraestructura (Servicios externos)
│
├── Email/                           # Integración con servicios de email
│   ├── IEmailService.cs             # Interface para servicio de email
│   └── EmailService.cs              # Implementación del servicio de email
│
├── MongoLogging/                    # Integración con MongoDB para logs
│   ├── IMongoLogger.cs              # Interface para el logger en MongoDB
│   └── MongoLogger.cs               # Implementación del logger
│
├── RedisCache/                      # Integración con Redis para caché
│   ├── ICacheService.cs             # Interface para servicio de cache
│   └── RedisCacheService.cs         # Implementación de Redis Cache
│
Conquiscamp.Shared/                   # Capa compartida (Clases comunes)
│
├── DTOs/                            # Data Transfer Objects
│   ├── EventDto.cs                  # DTO para la entidad Evento
│   ├── ScoreDto.cs                  # DTO para la entidad Puntaje
│   └── ClubDto.cs                   # DTO para la entidad Club
│
├── Results/                         # Clases para manejar resultados comunes
│   ├── ApiResponse.cs               # Clase base para respuestas API
│   └── ErrorResult.cs               # Resultado de error para la API
│
├── Claims/                          # Definición de Claims (roles, permisos)
│   ├── RoleClaims.cs                # Definición de roles (Admin, User, etc.)
│   └── PermissionClaims.cs          # Permisos a nivel de API
│
├── Helpers/                         # Clases auxiliares para lógica compartida
│   ├── JwtHelper.cs                 # Ayuda para generar y validar JWT
│   └── LoggingHelper.cs             # Ayuda para registrar logs estructurados
└── .env                              # Variables de entorno para configuración (seguridad)
