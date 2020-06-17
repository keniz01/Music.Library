FROM mcr.microsoft.com/dotnet/core/sdk:5.0 AS build-env
WORKDIR /app

COPY assemblies/*.dll ./
COPY /src/infrastructure/client/Music.Library.Api/*.csproj ./
RUN dotnet restore

COPY /src/infrastructure/client/Music.Library.Api/. ./
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/core/aspnet:5.0
WORKDIR /app
EXPOSE 80
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "Music.Library.Api.dll"]