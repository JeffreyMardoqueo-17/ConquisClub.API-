# Imagen base para ejecución
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 8080
EXPOSE 8081

# Imagen para construcción
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src

# Copiar todos los archivos .csproj y restaurar dependencias
COPY ["ConquisClub.API/ConquisClub.API.csproj", "ConquisClub.API/"]
COPY ["Conquiscamp.Application/Conquiscamp.Application.csproj", "Conquiscamp.Application/"]
COPY ["Conquiscamp.Domain/Conquiscamp.Domain.csproj", "Conquiscamp.Domain/"]
COPY ["Conquiscamp.Infrastructure/Conquiscamp.Infrastructure.csproj", "Conquiscamp.Infrastructure/"]
COPY ["Conquiscamp.Persistence.Sql/Conquiscamp.Persistence.Sql.csproj", "Conquiscamp.Persistence.Sql/"]
COPY ["Conquiscamp.Shared/Conquiscamp.Shared.csproj", "Conquiscamp.Shared/"]

RUN dotnet restore "ConquisClub.API/ConquisClub.API.csproj"

# Copiar el resto del código fuente
COPY . .

WORKDIR "/src/ConquisClub.API"
RUN dotnet build "ConquisClub.API.csproj" -c $BUILD_CONFIGURATION -o /app/build

# Publicar el proyecto
FROM build AS publish
ARG BUILD_CONFIGURATION=Release
RUN dotnet publish "ConquisClub.API.csproj" -c $BUILD_CONFIGURATION -o /app/publish /p:UseAppHost=false

# Imagen final
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "ConquisClub.API.dll"]
