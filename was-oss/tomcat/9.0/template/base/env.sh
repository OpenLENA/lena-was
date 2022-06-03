#!/bin/sh

## Business System Base Environment (modify them)
export JAVA_HOME=/usr/bin/java
export LAT_HOME=/apps/lat/1.0
export SERVER_ID=lat
export SERVICE_PORT=7000
export INSTALL_PATH=/apps/lat/1.0/servers/lat_7000
export WAS_USER=tomcat
export DATE=`date +%Y%m%d-%H%M%S`
export JVM_ROUTE=lat_7000
export SHUTDOWN_TIMEOUT=86400
export SHUTDOWN_ARGUMENTS="${SHUTDOWN_TIMEOUT} -force"

## Catalina Environment (don't modify them)
export PATH=${PATH}:.
export CATALINA_HOME=${INSTALL_PATH}
export CATALINA_BASE=${CATALINA_HOME}
export INST_NAME=${SERVER_ID}_`hostname`
export LOG_HOME=${INSTALL_PATH}/logs
export LOG_MAX_DAYS=0
export DUMP_HOME=${LOG_HOME}
export CATALINA_OUT=${LOG_HOME}/${INST_NAME}
#export CATALINA_OUT_CMD="${CATALINA_HOME}/bin/rotatelogs ${CATALINA_OUT}_%Y%m%d.log 86400 +540"
export CATALINA_PID=${CATALINA_HOME}/${INST_NAME}.pid
export AJP_ADDRESS=127.0.0.1
export AJP_SECRET=LAT_AJP_SECRET

## LA:T Server Configuration
export CATALINA_OPTS=" ${CATALINA_OPTS} -Dlat.name=${SERVER_ID}"


## Server custom settings 
if [ -r "$CATALINA_HOME/bin/customenv.sh" ]; then
  . "$CATALINA_HOME/bin/customenv.sh"
fi

export CATALINA_OPTS

## Catalina Java Options (don't modify them)
JAVA_OPTS=" ${JAVA_OPTS} -server"
#JAVA_OPTS=" ${JAVA_OPTS} -d64"
JAVA_OPTS=" ${JAVA_OPTS} -DjvmRoute=${JVM_ROUTE}"
JAVA_OPTS=" ${JAVA_OPTS} -Dwas_cname=${INST_NAME}"
JAVA_OPTS=" ${JAVA_OPTS} -Dport.http=${SERVICE_PORT}"
JAVA_OPTS=" ${JAVA_OPTS} -Dport.https=`expr ${SERVICE_PORT} + 363`"
JAVA_OPTS=" ${JAVA_OPTS} -Dport.ajp=`expr ${SERVICE_PORT} - 71`"
JAVA_OPTS=" ${JAVA_OPTS} -Dport.shutdown=`expr ${SERVICE_PORT} - 75`"
JAVA_OPTS=" ${JAVA_OPTS} -Dlog.home=${LOG_HOME}"
JAVA_OPTS=" ${JAVA_OPTS} -Dlat.home=${LAT_HOME}"
JAVA_OPTS=" ${JAVA_OPTS} -Dajp.address=${AJP_ADDRESS}"
JAVA_OPTS=" ${JAVA_OPTS} -Dajp.secret=${AJP_SECRET}"
JAVA_OPTS=" ${JAVA_OPTS} -Djdk.attach.allowAttachSelf=true"

export JAVA_OPTS
