#!/bin/sh

SCRIPTPATH=`cd $(dirname $0) ; pwd -P`
SCRIPT=$SCRIPTPATH/$(basename $0)

sh ${SCRIPTPATH}/stop.sh
sleep 3
sh ${SCRIPTPATH}/start.sh
