# ---------- BASE RUNTIME ----------
FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS base
WORKDIR /app

# IMPORTANT: make app listen on port 8080 inside container
ENV ASPNETCORE_URLS=http://+:8080

EXPOSE 8080


# ---------- BUILD STAGE ----------
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src

COPY ["GithubAction.csproj", "."]
RUN dotnet restore "./GithubAction.csproj"

COPY . .
RUN dotnet build "GithubAction.csproj" -c Release -o /app/build


# ---------- PUBLISH STAGE ----------
FROM build AS publish
RUN dotnet publish "GithubAction.csproj" -c Release -o /app/publish /p:UseAppHost=false


# ---------- FINAL RUNTIME IMAGE ----------
FROM base AS final
WORKDIR /app

COPY --from=publish /app/publish .

ENTRYPOINT ["dotnet", "GithubAction.dll"]