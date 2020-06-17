#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY infrastructure/client/Music.Library.Api/Music.Library.Api.csproj infrastructure/client/Music.Library.Api/
RUN dotnet restore "infrastructure/client/Music.Library.Api/Music.Library.Api.csproj"
COPY . .
WORKDIR "/src/infrastructure/client/Music.Library.Api"
RUN dotnet build "Music.Library.Api.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Music.Library.Api.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Music.Library.Api.dll"]
