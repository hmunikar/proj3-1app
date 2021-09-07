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



FROM registry.access.redhat.com/ubi8/dotnet-31:3.1 AS base
WORKDIR /app
COPY . .
#EXPOSE 80
#EXPOSE 443


FROM registry.access.redhat.com/ubi8/dotnet-31:3.1 AS publish
WORKDIR /app
COPY . .
#RUN mkdir /app
#RUN mkdir /app/publish
USER 0
RUN dotnet publish "proj3-1app.csproj" -c Release 
RUN ls /app/bin
#-o /app/publish


FROM registry.access.redhat.com/ubi8/dotnet-31:3.1
WORKDIR /app
ENTRYPOINT ["proj3-1app.dll"]
#WORKDIR /app
#COPY --from=publish /app/publish .
#RUN ls
#ENTRYPOINT ["proj3-1app.dll"]




## syntax=docker/dockerfile:1
#FROM registry.access.redhat.com/ubi8/dotnet-31:3.1 AS build-env
#WORKDIR /app

## Copy csproj and restore as distinct layers
#COPY *.csproj ./
#RUN dotnet restore

## Copy everything else and build
#COPY . ./
#RUN dotnet publish -c Release -o out

## Build runtime image
#FROM registry.access.redhat.com/ubi8/dotnet-31:3.1
#WORKDIR /app
#COPY --from=build-env /app/out .
#ENTRYPOINT ["dotnet", "proj3-1app.dll"]
