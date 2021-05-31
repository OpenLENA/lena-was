#!/bin/bash


RUNDIR=`dirname "$0"`
SERVER_HOME=`cd $RUNDIR; pwd -P`
SERVER_NAME=`echo $SERVER_HOME | awk -F/ '{print $NF}'`
LENA_HOME=`cd "$SERVER_HOME/../.."; pwd -P`


check_run_user() {
        RUN_USER=`whoami`
        if [ "$RUN_USER" != "root" ]; then
                echo "ERROR : This script must be run by the root user because of SYSTEMD registration."
                exit
        fi
}

check_os_version() {
        uname -r | egrep -q "amzn2|el7"
        if [ $? -ne 0 ]; then
                echo "ERROR : This script must be run on Redhat_Based_Linux Verion 7."
                exit
        fi
}

check_env_sh() {
        if [ ! -e $ENV_FILE ]; then
                echo "ERROR : env.sh does not exist."
                exit
        fi

}

define_server_info() {
	ENV_FILE=$SERVER_HOME/env.sh
	check_env_sh

	LENA_USER=`cat $ENV_FILE | egrep "WAS_USER|RUN_USER" | awk -F= '{print $2}'`
	SERVICE_NAME=$SERVER_NAME
}

check_service_template() {
        if [ ! -e $TEMP_FILE ]; then
                echo "ERROR : lena-service.template does not exist."
                exit
        fi
}

create_service() {
        TEMP_FILE=$LENA_HOME/etc/script/lena-service.template
        NEW_FILE=$LENA_HOME/etc/script/$SERVICE_NAME.service
        check_service_template

        DESCRIPTION=$SERVICE_NAME
        EXECSTART=$SERVER_HOME/start.sh
        EXECSTOP=$SERVER_HOME/stop.sh
        WORKINGDIRECTORY=$SERVER_HOME

        cp $TEMP_FILE $NEW_FILE

        sed -i "s:DSCRTEMPLATE:$DESCRIPTION:g" $NEW_FILE
        sed -i "s:USERTEMPLATE:$LENA_USER:g" $NEW_FILE
        sed -i "s:EXECSTARTTEMPLATE:$EXECSTART:g" $NEW_FILE
        sed -i "s:EXECSTOPTEMPLATE:$EXECSTOP:g" $NEW_FILE
        sed -i "s:WORKDIRTEMPLATE:$WORKINGDIRECTORY:g" $NEW_FILE
}

check_service_running() {
	systemctl status $SERVICE_NAME > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "ERROR : $SERVICE_NAME.service is already registered and activated. You need to stop $SERVICE_NAME.service first."
		exit
	fi
}

register_service() {
	check_service_running
	
        mv $NEW_FILE /usr/lib/systemd/system/$SERVICE_NAME.service
        systemctl daemon-reload
        systemctl enable $SERVICE_NAME > /dev/null 2>&1
        echo "Service is Successfully registered : $SERVICE_NAME"
}

deregister_service() {
	check_service_running

	systemctl disable $SERVICE_NAME > /dev/null 2>&1
	rm -f /usr/lib/systemd/system/$SERVICE_NAME.service
	rm -f /etc/systemd/system/multi-user.target.wants/$SERVICE_NAME.service
	systemctl daemon-reload
	systemctl reset-failed
	echo "Service is Successfully deregistered : $SERVICE_NAME"
}


check_run_user
check_os_version
case $1 in
        register)
                define_server_info
                create_service
                register_service
                ;;
        deregister)
                define_server_info
		deregister_service
                ;;
        *)
                echo "Usage: $0 {register|deregister}"

esac