#!/bin/sh

# defaults

# ip 0.0.0.0
if [ -z "${APP_IP}" ]; then
APP_IP=0.0.0.0
fi

# port 5000
if [ -z "${APP_PORT}" ]; then
APP_PORT=5000
fi

# protocol http or uwsgi
if [ -z "${APP_PROTOCOL}" ]; then
APP_PROTOCOL=http
fi

# mount path
if [ -z "${APP_PATH}" ]; then
APP_PATH=/
fi

# module name
if [ -z "${APP_MODULE}" ]; then
APP_MODULE=flask
fi

# processes and threads
if [ -z "${PROCESSES}" ]; then
PROCESSES=1
fi
if [ -z "${THREADS}" ]; then
THREADS=1
fi


echo "Starting uwsgi server for ${APP_NAME}."
echo "Listen on url: ${APP_PROTOCOL}://${APP_IP}:${APP_PORT}${APP_PATH}"
echo "       Module: ${APP_MODULE}"
echo "    Processes: ${PROCESSES}"
echo "      Threads: ${THREADS}"
echo ""

cd /app
uwsgi --socket ${APP_IP}:${APP_PORT} --protocol ${APP_PROTOCOL} --mount ${APP_PATH}=${APP_MODULE}:app --manage-script-name --processes ${PROCESSES} --threads ${THREADS}
