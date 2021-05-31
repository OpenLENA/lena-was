#!/bin/sh

SCRIPTPATH=`cd $(dirname $0) ; pwd -P`
SCRIPT=$SCRIPTPATH/$(basename $0)
ARGUMENTS=$@

. ${SCRIPTPATH}/env.sh

if [ -z "$ARGUMENTS" ] && [ -n "$SHUTDOWN_ARGUMENTS" ]; then
	ARGUMENTS=${SHUTDOWN_ARGUMENTS}
fi

SETUSER=${WAS_USER}
RUNNER=`whoami`

if [ ${RUNNER} != ${SETUSER} ] ;
   then echo "Deny Access : [ ${RUNNER} ]. Not ${SETUSER}" ;
   exit 1 ;
fi

ps_check(){
	if [ "`uname -s`" = "HP-UX" ]; then
		ps -efx | grep java | grep "was_cname=${INST_NAME} "| wc -l
	else
		ps -ef | grep bin/java | grep "catalina.home=${CATALINA_HOME} "| wc -l
	fi
}

[ `ps_check` -eq 0 ] && echo "##### ${INST_NAME} is not running. There is nothing to stop.#######" && exit 1

##  Tomcat shutdwn command
JAVA_OPTS=" ${JAVA_OPTS} -Xms64m -Xmx64m"
${CATALINA_HOME}/bin/shutdown.sh ${ARGUMENTS}

if [ -e "${CATALINA_OUT_PIPE}" ] ; then
	rm -rf ${CATALINA_OUT_PIPE}
fi

echo "Execute ./stop.sh by [ `whoami` ]" >> ${CATALINA_OUT}_`date +%Y%m%d`.log

if [ `ps_check` -eq 0 ];
 then echo "##### ${INST_NAME} successfully shut down ###### "
 else echo "##### Fail to stop ${INST_NAME}!!  Check Again!! ###### "
fi
 



 