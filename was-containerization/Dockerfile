# FROM IMAGE will be changed by docker build argument
ARG FROM_IMAGE=MustInputBuildArg
FROM docker.io/${FROM_IMAGE}

ENV LENA_HOME /usr/local/lena
#ARG JDK_HOME=/usr/lib/jvm/java
#ENV JAVA_HOME ${JDK_HOME}
ENV SERVER_NAME appServer
ENV SERVICE_PORT 8180

# create LENA HOME
RUN mkdir -p /usr/local/lena
# copy LENA install files
COPY was-dist/target/lena-work/*.tar.gz was-containerization/install.sh was-containerization/entrypoint.sh ${LENA_HOME}

# Insall LENA
RUN cd ${LENA_HOME} \
	&& chmod +x *.sh \
	&& ${LENA_HOME}/install.sh \
	&& rm -f ${LENA_HOME}/install.sh

WORKDIR $LENA_HOME
CMD ["./entrypoint.sh"]
