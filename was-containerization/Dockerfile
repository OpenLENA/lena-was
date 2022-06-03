# FROM IMAGE will be changed by docker build argument
ARG FROM_IMAGE=MustInputBuildArg
FROM docker.io/${FROM_IMAGE}

ENV LAT_HOME /usr/local/lat
#ARG JDK_HOME=/usr/lib/jvm/java
#ENV JAVA_HOME ${JDK_HOME}
ENV SERVER_NAME appServer
ENV SERVICE_PORT 8180

# create LAT HOME
RUN mkdir -p /usr/local/lat
# copy LENA install files
COPY was-dist/target/lat-work/*.tar.gz was-containerization/install.sh was-containerization/entrypoint.sh ${LAT_HOME}

# Insall LENA
RUN cd ${LAT_HOME} \
	&& chmod +x *.sh \
	&& ${LAT_HOME}/install.sh \
	&& rm -f ${LAT_HOME}/install.sh

WORKDIR $LAT_HOME
CMD ["./entrypoint.sh"]
