#!/bin/bash

ORIENTEER_PRODUCTION=${ORIENTEER_PRODUCTION-false}
export ORIENTEER_PRODUCTION

if [ -n "$ORIENTDB_PORT_2424_TCP_ADDR" ] && [ -z "$ORIENTDB_HOST" ]; then
	ORIENTDB_HOST=$ORIENTDB_PORT_2424_TCP_ADDR
fi

ORIENTDB_HOST=${ORIENTDB_HOST-localhost}
export ORIENTDB_HOST

ORIENTDB_DB=${ORIENTDB_DB-Orienteer}
export ORIENTDB_DB

cp /app/orienteer.properties /app/.orienteer.properties

sed -i "/orienteer.production=true/a orienteer.production=$ORIENTEER_PRODUCTION" /app/.orienteer.properties

if [ -n "$ORIENTDB_HOST" ] && [ "$ORIENTDB_HOST" != "localhost" ]; then
	sed -i "/orientdb.embedded=true/a orientdb.embedded=false" /app/.orienteer.properties
	sed -i "/orientdb.url=plocal:Orienteer/a orientdb.url=remote:$ORIENTDB_HOST\/$ORIENTDB_DB" /app/.orienteer.properties
else
	sed -i "/orientdb.url=plocal:Orienteer/a orientdb.url=plocal:$ORIENTDB_DB" /app/.orienteer.properties
fi

if [ -n "$ORIENTDB_DB_USER" ]; then
	sed -i "/orientdb.db.username=reader/a orientdb.db.username=$ORIENTDB_DB_USER" /app/.orienteer.properties
fi

if [ -n "$ORIENTDB_DB_USER_PASSWORD" ]; then
	sed -i "/orientdb.db.password=reader/a orientdb.db.password=$ORIENTDB_DB_USER_PASSWORD" /app/.orienteer.properties
fi

if [ -n "$ORIENTDB_ROOT_USER" ]; then
	sed -i "/orientdb.db.installator.username=admin/a orientdb.db.installator.username=$ORIENTDB_ROOT_USER" /app/.orienteer.properties
fi

if [ -n "$ORIENTDB_ROOT_USER_PASSWORD" ]; then
	sed -i "/orientdb.db.installator.password=admin/a orientdb.db.installator.password=$ORIENTDB_ROOT_USER_PASSWORD" /app/.orienteer.properties
fi

java -Xmx512m -Xms512m -jar /app/orienteer-standalone.jar --config=/app/.orienteer.properties
rm -f /app/.orienteer.properties