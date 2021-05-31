## JVM Memory Options (tune them)
CATALINA_OPTS=" ${CATALINA_OPTS} -Xms2048m -Xmx2048m"
CATALINA_OPTS=" ${CATALINA_OPTS} -XX:MaxMetaspaceSize=256m"
CATALINA_OPTS=" ${CATALINA_OPTS} -XX:+UseParallelGC"
CATALINA_OPTS=" ${CATALINA_OPTS} -XX:+UseParallelOldGC"
CATALINA_OPTS=" ${CATALINA_OPTS} -XX:-UseAdaptiveSizePolicy"
CATALINA_OPTS=" ${CATALINA_OPTS} -XX:+ExplicitGCInvokesConcurrent"
CATALINA_OPTS=" ${CATALINA_OPTS} -XX:+HeapDumpOnOutOfMemoryError"
CATALINA_OPTS=" ${CATALINA_OPTS} -XX:HeapDumpPath=${DUMP_HOME}/hdump"
CATALINA_OPTS=" ${CATALINA_OPTS} -Djava.net.preferIPv4Stack=true"
## JVM Memory Options (for JDK8 or below)
if [ -r "${JAVA_HOME}/lib/tools.jar" ]; then
  CATALINA_OPTS=" ${CATALINA_OPTS} -Xloggc:${LOG_HOME}/gc_${INST_NAME}_${DATE}.log"
  CATALINA_OPTS=" ${CATALINA_OPTS} -verbose:gc"
  CATALINA_OPTS=" ${CATALINA_OPTS} -XX:+PrintGCDetails"
  CATALINA_OPTS=" ${CATALINA_OPTS} -XX:+PrintGCDateStamps"
fi
## JVM Memory Options (for JDK11 or above)
if [ -r "${JAVA_HOME}/lib/jrt-fs.jar" ]; then
  CATALINA_OPTS=" ${CATALINA_OPTS} -Xlog:gc:${LOG_HOME}/gc_${INST_NAME}_${DATE}.log"
fi

## Business System Java Options (for your application)
#CATALINA_OPTS=" ${CATALINA_OPTS} "
## Faster Secure Random
CATALINA_OPTS=" ${CATALINA_OPTS} -Djava.security.egd=file:///dev/urandom"

export CATALINA_OPTS

## Add tools.jar to CLASSPATH
if [ -r ${JAVA_HOME}/lib/tools.jar ]; then
  CLASSPATH="${CLASSPATH}:${JAVA_HOME}/lib/tools.jar"
fi

## Business System CLASSPATH (for your application)
#CLASSPATH="${CLASSPATH}:${CATALINA_HOME}/lib/datasource/ojdbc6.jar"
export CLASSPATH

## LIBRARY_PATH
LD_LIBRARY_PATH=${CATALINA_HOME}/lib
export LD_LIBRARY_PATH

## Logging output options ('file' or 'console') 
LOG_OUTPUT=file
export LOG_OUTPUT
