#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM registry.access.redhat.com/ubi8/dotnet-31:3.1 AS build
WORKDIR /app
COPY . .
#RUN mkdir /app
#RUN mkdir /app/publish
USER 0
RUN dotnet publish "proj3-1app.csproj" -c Release -o .
ENTRYPOINT ["dotnet", "proj3-1app.dll"]

