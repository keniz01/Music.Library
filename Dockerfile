FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build-env
WORKDIR /app

COPY assemblies/*.dll ./
COPY /src/infrastructure/client/Music.Library.Api/*.csproj ./
RUN dotnet restore

COPY /src/infrastructure/client/Music.Library.Api/. ./
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
WORKDIR /app
EXPOSE 80
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "Music.Library.Api.dll"]