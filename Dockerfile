#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM myproject/dotnet:3.1-ubi8
WORKDIR /app
COPY . .
USER 0
RUN dotnet publish "proj3-1app.csproj" -c Release -o .
ENTRYPOINT ["dotnet", "proj3-1app.dll"]

