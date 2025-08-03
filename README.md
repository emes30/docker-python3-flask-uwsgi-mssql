## docker-python3-flask-uwsgi-mssql

#### Python3 environment ready for deploy flask applications with uwsgi and Microsoft SQL Server client

This is Docker image I use for deploy python flask applications that use Microsoft SQL Server as database.
It uses pyodbc and SQLAlchemy for database related stuff.

Based on Debian 12.

Python has already installed following packages and its dependancies:

```
alembic==1.16.4
aniso8601==10.0.1
astroid==3.3.11
blinker==1.9.0
certifi==2025.8.3
charset-normalizer==3.4.2
click==8.2.1
colorama==0.4.6
dill==0.4.0
dnspython==2.7.0
eventlet==0.40.2
Flask==3.1.1
Flask-JWT-Extended==4.7.1
Flask-RESTful==0.3.10
greenlet==3.2.3
gunicorn==23.0.0
idna==3.10
isort==6.0.1
itsdangerous==2.2.0
Jinja2==3.1.6
lxml==6.0.0
Mako==1.3.10
MarkupSafe==3.0.2
mccabe==0.7.0
packaging==25.0
platformdirs==4.3.8
PyJWT==2.10.1
pylint==3.3.7
pytz==2025.2
requests==2.32.4
six==1.17.0
SQLAlchemy==2.0.42
tomli==2.2.1
tomlkit==0.13.3
typing_extensions==4.14.1
urllib3==2.5.0
Werkzeug==3.1.3
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
