#!/bin/sh

SCRIPTPATH=`cd $(dirname $0) ; pwd -P`
SCRIPT=$SCRIPTPATH/$(basename $0)

. ${SCRIPTPATH}/../env.sh
. ${SCRIPTPATH}/setenv.sh

printenv

exit 0;