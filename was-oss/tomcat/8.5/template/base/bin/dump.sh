#!/bin/sh

SCRIPTPATH=`cd $(dirname $0) ; pwd -P`
SCRIPT=$SCRIPTPATH/$(basename $0)

. ${SCRIPTPATH}/../env.sh
. ${SCRIPTPATH}/setenv.sh

ARGUMENTS=$@
DATE=`date +%Y%m%d-%H%M%S`

if [ ! -r ${CATALINA_PID} ]; then
	echo "Process is not alive."
	exit 1;
fi

if [ "$1" = "t" ] ; then
  ${JAVA_HOME}/bin/jstack `cat ${CATALINA_PID}` > ${DUMP_HOME}/tdump/"$2"
fi
if [ "$1" = "h" ]; then
  ${JAVA_HOME}/bin/jmap -dump:format=b,file=${DUMP_HOME}/hdump/"$2" `cat ${CATALINA_PID}`
fi

#IBM JDK Thread Dump
if [ "$1" = "it" ]; then
  kill -3 `cat ${CATALINA_PID}`
fi

#IBM JDK Heap Dump
if [ "$1" = "ih" ]; then
  gencore `cat ${CATALINA_PID}` ${DUMP_HOME}/hdump/"$2"
fi