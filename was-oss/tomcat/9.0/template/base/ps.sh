#!/bin/sh

SCRIPTPATH=`cd $(dirname $0) ; pwd -P`
SCRIPT=$SCRIPTPATH/$(basename $0)

. ${SCRIPTPATH}/env.sh
if [ "`uname -s`" = "HP-UX" ]; then
	ps -efx|grep java|grep was_cname=${INST_NAME}
else
	ps -ef|grep bin/java|grep "catalina.home=${CATALINA_HOME} "
fi
