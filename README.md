## docker-python3-flask-uwsgi-mssql

#### Python3 environment ready for deploy flask applications with uwsgi and Microsoft SQL Server client

This is Docker image I use for deploy python flask applications that use Microsoft SQL Server as database.
It uses pyodbc and SQLAlchemy for database related stuff.

Based on Debian 12.

Python has already installed following packages and its dependancies:

```
alembic==1.13.1
aniso8601==9.0.1
astroid==3.1.0
blinker==1.7.0
certifi==2024.2.2
charset-normalizer==3.3.2
click==8.1.7
colorama==0.4.6
dill==0.3.8
Flask==3.0.2
Flask-RESTful==0.3.10
greenlet==3.0.3
idna==3.6
isort==5.13.2
itsdangerous==2.1.2
Jinja2==3.1.3
lxml==5.1.0
Mako==1.3.2
MarkupSafe==2.1.5
mccabe==0.7.0
platformdirs==4.2.0
pylint==3.1.0
pytz==2024.1
requests==2.31.0
six==1.16.0
SQLAlchemy==2.0.28
tomli==2.0.1
tomlkit==0.12.4
typing_extensions==4.10.0
urllib3==2.2.1
Werkzeug==3.0.1
```

All you need to add is your application files, and simple script for start.

Image starts uwsgi server, it can be configured via environment variables.
You can use it with nginx or standalone.

Following setup

```
APP_IP=0.0.0.0
APP_PORT=5000
APP_PROTOCOL=http
APP_PATH=/
APP_MODULE=flask
PROCESSES=1
THREADS=1
```

produces this command to start uwsgi server.

`uwsgi --socket 0.0.0.0:5000 --protocol http --mount /=flask:app --manage-script-name --processes 1 --threads 1`

Here is Dockerfile example, it cannot be simplier:

```
FROM emes/python3

WORKDIR /app

COPY . .
```

and this is command for building your container:

`docker run -e APP_MODULE=my_module emes/my-module`

nginx configuration:

```
location /yourapp
{
  uwsgi_pass your_app_ip:5000;
  include uwsgi_params;
}
```
