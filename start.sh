#!/bin/bash

ORIENTEER_PRODUCTION=${ORIENTEER_PRODUCTION-true}
export ORIENTEER_PRODUCTION

if [ -n "$ORIENTDB_PORT_2480_TCP_ADDR" ] && [ -z "$ORIENTDB_HOST" ]; then
	ORIENTDB_HOST=$ORIENTDB_PORT_2480_TCP_ADDR
fi

if [ -n "$ORIENTDB_ENV_ORIENTDB_DB" ]; then
	ORIENTDB_DB=$ORIENTDB_ENV_ORIENTDB_DB
fi

if [ -n "$ORIENTDB_ENV_ORIENTDB_DB_USER" ]; then
	ORIENTDB_DB_USER=$ORIENTDB_ENV_ORIENTDB_DB_USER
fi

if [ -n "$ORIENTDB_ENV_ORIENTDB_DB_USER_PASSWORD" ]; then
	ORIENTDB_DB_USER_PASSWORD=$ORIENTDB_ENV_ORIENTDB_DB_USER_PASSWORD
fi

if [ -n "$ORIENTDB_ENV_ORIENTDB_ROOT_USER" ]; then
	ORIENTDB_ROOT_USER=$ORIENTDB_ENV_ORIENTDB_ROOT_USER
fi

if [ -n "$ORIENTDB_ENV_ORIENTDB_ROOT_USER_PASSWORD" ]; then
	ORIENTDB_ROOT_USER_PASSWORD=$ORIENTDB_ENV_ORIENTDB_ROOT_USER_PASSWORD
fi

if [ -n "$ORIENTDB_PORT_2424_TCP_PORT" ]; then
	ORIENTDB_PORT=$ORIENTDB_PORT_2424_TCP_PORT
fi

if [ -n "$ORIENTDB_PORT_2480_TCP_PORT" ]; then
	ORIENTDB_HTTP_PORT=$ORIENTDB_PORT_2480_TCP_PORT
fi

ORIENTDB_PORT=${ORIENTDB_PORT-2424}
export ORIENTDB_PORT

ORIENTDB_HOST=${ORIENTDB_HOST-localhost}
export ORIENTDB_HOST

ORIENTDB_DB=${ORIENTDB_DB-Orienteer}
export ORIENTDB_DB

cp /app/orienteer.properties /app/.orienteer.properties

sed -i "s/orienteer.production=true/orienteer.production=$ORIENTEER_PRODUCTION/g" /app/.orienteer.properties

if [ -n "$ORIENTDB_HOST" ] && [ "$ORIENTDB_HOST" != "localhost" ]; then
	sed -i "s/orientdb.embedded=true/orientdb.embedded=false/g" /app/.orienteer.properties
	sed -i "s/orientdb.url=plocal:Orienteer/orientdb.url=remote:$ORIENTDB_HOST:$ORIENTDB_PORT\/$ORIENTDB_DB/g" /app/.orienteer.properties
else
	sed -i "s/orientdb.url=plocal:Orienteer/orientdb.url=plocal:$ORIENTDB_DB/g" /app/.orienteer.properties
fi

if [ -n "$ORIENTDB_DB_USER" ]; then
	sed -i "s/orientdb.db.username=reader/orientdb.db.username=$ORIENTDB_DB_USER/g" /app/.orienteer.properties
fi

if [ -n "$ORIENTDB_DB_USER_PASSWORD" ]; then
	sed -i "s/orientdb.db.password=reader/orientdb.db.password=$ORIENTDB_DB_USER_PASSWORD/g" /app/.orienteer.properties
fi

if [ -n "$ORIENTDB_ROOT_USER" ]; then
	sed -i "s/orientdb.db.installator.username=admin/orientdb.db.installator.username=$ORIENTDB_ROOT_USER/g" /app/.orienteer.properties
fi

if [ -n "$ORIENTDB_ROOT_USER_PASSWORD" ]; then
	sed -i "s/orientdb.db.installator.password=admin/orientdb.db.installator.password=$ORIENTDB_ROOT_USER_PASSWORD/g" /app/.orienteer.properties
fi

java -Xmx512m -Xms512m -jar /app/orienteer-standalone.jar --config=/app/.orienteer.properties
rm -f /app/.orienteer.properties