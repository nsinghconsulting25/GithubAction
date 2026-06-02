# ---------- BASE RUNTIME (small image) ----------
FROM mcr.microsoft.com/dotnet/aspnet:10.0-alpine AS base
WORKDIR /app

ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080


# ---------- BUILD STAGE ----------
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src

# Copy only csproj first (better cache)
COPY GithubAction.csproj ./
RUN dotnet restore

# Copy everything else
COPY . ./

RUN dotnet build -c Release -o /app/build


# ---------- PUBLISH STAGE ----------
FROM build AS publish

RUN dotnet publish -c Release \
    -o /app/publish \
    /p:UseAppHost=false \
    /p:SelfContained=false

# ---------- FINAL RUNTIME ----------
FROM mcr.microsoft.com/dotnet/aspnet:10.0-alpine AS final
WORKDIR /app

COPY --from=publish /app/publish .

ENTRYPOINT ["dotnet", "GithubAction.dll"]