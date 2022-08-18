FROM mcr.microsoft.com/dotnet/sdk:6.0 as builder
WORKDIR /build
COPY src/ .
RUN ["dotnet", "build"]

FROM mcr.microsoft.com/dotnet/sdk:6.0 as unittests
WORKDIR /unittests
COPY --from=builder /build/project.unittests/bin/Debug/net6.0/ .
CMD ["dotnet", "test", "project.unittests.dll"]

FROM mcr.microsoft.com/dotnet/sdk:6.0 as integrationtests
WORKDIR /integrationtests
COPY --from=builder /build/project.integrationtests/bin/Debug/net6.0/ .
CMD ["dotnet", "test", "project.integrationtests.dll"]
