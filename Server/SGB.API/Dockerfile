#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["SGB.API/SGB.API.csproj", "SGB.API/"]
RUN dotnet restore "SGB.API/SGB.API.csproj"
COPY . .
WORKDIR "/src/SGB.API"
RUN dotnet build "SGB.API.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "SGB.API.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "SGB.API.dll"]