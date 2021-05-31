#!/bin/sh

SCRIPTPATH=`cd $(dirname $0) ; pwd -P`
SCRIPT=$SCRIPTPATH/$(basename $0)

. ${SCRIPTPATH}/env.sh

SETUSER=${WAS_USER}
RUNNER=`whoami`

if [ ${RUNNER} = "root" ] ;
  then >&2 echo "Deny Access : [ ${RUNNER} ]." ;
  exit 1 ;
fi

if [ ${RUNNER} != ${SETUSER} ] ;
  then >&2 echo "Deny Access : [ ${RUNNER} ]. Not ${SETUSER}" ;
  exit 1 ;
fi

if [ "`uname -s`" = "HP-UX" ]; then
  ps -efx | grep java | grep -q "was_cname=${INST_NAME} " && echo "##### ERROR. ${INST_NAME} is already running. exiting.. #####" && exit 1
else
  ps -ef | grep bin/java | grep -q "catalina.home=${CATALINA_HOME} " && echo "##### ERROR. ${INST_NAME} is already running. exiting.. #####" && exit 1
fi

if [ -r "$CATALINA_PID" ]; then
  echo "Existing PID file found during start."
  echo "Removing/clearing stale PID file."
  rm -f "$CATALINA_PID" >/dev/null 2>&1
  if [ $? != 0 ]; then
    echo "Unable to remove or clear stale PID file. Start aborted."
    exit 1
  fi
fi

# DATE=`date +%Y-%m-%d_%H-%M-%S`
LOG_DATE=`date +%Y%m%d`

_log_dirs="access gclog nohup"
for _dir in `echo $_log_dirs`
do
  if [ ! -d ${LOG_HOME}/${_dir} ]; then
    mkdir -p ${LOG_HOME}/${_dir}
    if [ $? -ne 0 ]; then
  	echo >&2 "cannot create log directory '${LOG_HOME}/${_dir}'";
  	echo >&2 "Startup failed."
  	exit 1;
    fi
  fi
done

_dump_dirs="hdump hdump/oom sdump tdump"
for _dir in `echo $_dump_dirs`
do
  if [ ! -d ${DUMP_HOME}/${_dir} ]; then
    mkdir -p ${DUMP_HOME}/${_dir}
    if [ $? -ne 0 ]; then
  	echo >&2 "cannot create dump directory '${DUMP_HOME}/${_dir}'";
  	echo >&2 "Startup failed."
  	exit 1;
    fi
  fi
done

if [ 0 -ne `ls ${LOG_HOME} | grep "gc_${INST_NAME}.*" | wc -l` ]; then
  mv ${LOG_HOME}/gc_${INST_NAME}*.log ${LOG_HOME}/gclog
fi

if [ 0 -ne `ls ${LOG_HOME} | grep "${INST_NAME}.*" | grep -v "${LOG_DATE}" | wc -l` ]; then
  cd ${LOG_HOME}
  for LOG_FILE in `ls ${INST_NAME}*.log | grep -v "${LOG_DATE}"`
  do
    mv ${LOG_FILE} nohup/
  done
fi

if [ 0 -ne `ls ${LOG_HOME} | grep "access_${INST_NAME}.*" | grep -v "${LOG_DATE}" | wc -l` ]; then
  cd ${LOG_HOME}
  for LOG_FILE in `ls access_${INST_NAME}*.log | grep -v "${LOG_DATE}"`
  do
    mv ${LOG_FILE} access/
  done
fi

cd ${CATALINA_HOME}
if [ "${1}" = "foreground" ]; then
  shift
  ${CATALINA_HOME}/bin/catalina.sh run "$@"
else
  ${CATALINA_HOME}/bin/startup.sh
fi
