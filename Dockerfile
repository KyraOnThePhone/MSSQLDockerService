FROM mcr.microsoft.com/mssql/server:2022-latest
USER root
RUN apt-get update && \
    apt-get install -y curl apt-transport-https gnupg && \
    curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
    apt-get update && \
    ACCEPT_EULA=Y apt-get install -y mssql-tools unixodbc-dev && \
    rm -rf /var/lib/apt/lists/*

# Füge mssql-tools zu PATH hinzu
ENV PATH="$PATH:/opt/mssql-tools/bin"

COPY init.sql /var/opt/mssql/init.sql

CMD ["tail", "-f", "/dev/null"]
