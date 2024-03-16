#See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["api/DemoServerlessPlatform.csproj", "api/"]
RUN dotnet restore "api/DemoServerlessPlatform.csproj"
COPY . .
WORKDIR "/src/api"
RUN dotnet build "DemoServerlessPlatform.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "DemoServerlessPlatform.csproj" -c Release -o /app/publish -p PublishReadyToRun=true -r linux-arm64


FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "DemoServerlessPlatform.dll"]