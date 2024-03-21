FROM python:3.12-slim

LABEL maintainer="Michał Sobczak <michal@sobczak.tech>"

COPY ./requirements.txt /tmp/requirements.txt

COPY ./dev.pack /tmp/dev.pack

RUN apt-get update && apt-get -y install curl apt-utils gnupg

RUN curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /usr/share/keyrings/microsoft-prod.gpg

RUN curl https://packages.microsoft.com/config/debian/12/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
    apt-get -y install apt-transport-https && \
    apt-get update && \
    pip install --upgrade pip && \
    pip install --upgrade setuptools

RUN apt-get -y install build-essential && pip install uwsgi  && \
    ACCEPT_EULA=Y apt-get install -y msodbcsql18 && \
    pip install --no-cache-dir -r /tmp/requirements.txt && \
    apt-get -y remove --purge `cat /tmp/dev.pack`

COPY openssl.cnf /etc/ssl/

WORKDIR /app

COPY run.sh .

ENTRYPOINT ["/app/run.sh"]
