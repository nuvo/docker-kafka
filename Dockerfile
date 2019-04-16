# Kafka and Zookeeper
FROM openjdk:8-jre-slim

ARG SCALA_VERSION=2.12
ARG KAFKA_VERSION=2.2.0

ENV DEBIAN_FRONTEND noninteractive
ENV KAFKA_HOME /opt/kafka

# Install Kafka, Zookeeper and other needed things
RUN set -ex && \
  apt-get -qq update && \
  apt-get install -y --no-install-recommends zookeeper wget supervisor dnsutils netcat && \
  wget -q -P /tmp/ https://archive.apache.org/dist/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz && \
  mkdir -p ${KAFKA_HOME} && \
  tar -zxf /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz --strip-components=1 -C /opt/kafka && \
  rm -rf /tmp/* && rm -rf /var/lib/apt/lists/* && apt-get clean

COPY scripts/start-kafka.sh /usr/bin/start-kafka.sh

# Supervisor config
COPY supervisor/kafka.conf supervisor/zookeeper.conf /etc/supervisor/conf.d/

# 2181 is zookeeper, 9092 is kafka
EXPOSE 2181 9092

CMD ["supervisord", "-n"]
