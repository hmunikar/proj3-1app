#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM registry.access.redhat.com/ubi8/dotnet-31:3.1 AS build
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
COPY --from=build /app/bin/Release/netcoreapp3.1/publish .
ENTRYPOINT ["dotnet", "proj3-1app.dll"]

