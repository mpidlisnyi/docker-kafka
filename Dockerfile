FROM java:openjdk-8-jre
MAINTAINER Maksym Pidlisnyi <maksim@nightbook.info>


ENV KAFKA_VERSION 0.10.1.0
ENV KAFKA_HOME /usr/local/kafka
ENV SCALA_VERSION 2.10
ENV BASENAME kafka_${SCALA_VERSION}-${KAFKA_VERSION}
ENV MIRROR_URL http://apache.mirrors.spacedump.net
ENV PACKAGE_URL ${MIRROR_URL}/kafka/${KAFKA_VERSION}/${BASENAME}.tgz
ENV PATH ${PATH}:${KAFKA_HOME}/bin

RUN mkdir -p ${KAFKA_HOME} && \
    wget -q ${PACKAGE_URL} -O /tmp/kafka.tgz && \
    tar xf /tmp/kafka.tgz --strip-components=1 -C ${KAFKA_HOME} && \
    rm /tmp/kafka.tgz

COPY entrypoint.sh /entrypoint
RUN chmod +x /entrypoint

WORKDIR ${KAFKA_HOME}

COPY log4j.properties config/log4j.properties

ENTRYPOINT [ "/entrypoint" ]
