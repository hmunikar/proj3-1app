#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

#FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-buster-slim AS base
#WORKDIR /app
#EXPOSE 80
#EXPOSE 443
#
#FROM mcr.microsoft.com/dotnet/core/sdk:3.1-buster AS build
#WORKDIR /src
#COPY ["proj3-1app.csproj", ""]
#RUN dotnet restore "./proj3-1app.csproj"
#COPY . .
#WORKDIR "/src/."
#RUN dotnet build "proj3-1app.csproj" -c Release -o /app/build
#
#FROM build AS publish
#RUN dotnet publish "proj3-1app.csproj" -c Release -o /app/publish
#
#FROM base AS final
#WORKDIR /app
#COPY --from=publish /app/publish .
#ENTRYPOINT ["dotnet", "proj3-1app.dll"]



#FROM demoproj/dotnet:3.1-ubi8
#
#RUN mkdir /app/proj3-1app
#WORKDIR /app/proj3-1app
#ADD . .
#
#RUN dotnet publish -c Release -o /app/proj3-1app/publish
#
#WORKDIR /app/proj3-1app/publish
#
#EXPOSE 8080
#
#ENTRYPOINT ["dotnet", "proj3-1app.dll"]



# syntax=docker/dockerfile:1
FROM 172.30.1.1:5000/demoproj/dotnet:3.1-ubi8 AS build-env
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY *.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY . ./
RUN dotnet publish -c Release -o out

# Build runtime image
FROM 172.30.1.1:5000/demoproj/dotnet:3.1-ubi8
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "proj3-1app.dll"]
