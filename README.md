# Kafka in Docker

This repository provides everything you need to run Kafka in Docker.

## Disclaimer

This isn't production grade nor is it intended for production usage. This image doesn't setup any volumes to persist data 
or other fault tolerance mechanism, and running kafka and zookeeper on the same host is really a bad idea.

Also note that this image runs as `root`, so it's *really* a bad idea to run it anywhere other than local development boxes.

It's intended mostly for development and prototyping, when you need a local kafka instance without all the shebang.

## Why?

The main hurdle of running Kafka in Docker is that it depends on Zookeeper.
Compared to other Kafka docker images, this one runs both Zookeeper and Kafka
in the same container. This means:

* No dependency on an external Zookeeper host, or linking to another container
* Zookeeper and Kafka are configured to work together out of the box

## What's included?

* `zookeeper`, version `3.4.9-3+deb9u1`. It's the latest stable in debian's stretch [repos](https://packages.debian.org/stretch/zookeeper).
* `kafka`, version 2.1.0, scala 2.12 [link](https://kafka.apache.org/downloads#2.1.0)
* `wget`
* `netcat`
* `supervisor`

## Run

```bash
docker run -p 2181:2181 -p 9092:9092 --env ADVERTISED_HOST=`docker-machine ip \`docker-machine active\`` --env ADVERTISED_PORT=9092 nuvo/docker-kafka
```

## Examples

See the examples folder for:
* `docker-compose.yaml`
* `kubernetes.yaml`

```bash
export KAFKA=`docker-machine ip \`docker-machine active\``:9092
kafka-console-producer.sh --broker-list $KAFKA --topic test
```

```bash
export ZOOKEEPER=`docker-machine ip \`docker-machine active\``:2181
kafka-console-consumer.sh --zookeeper $ZOOKEEPER --topic test
```

## Public Builds

https://registry.hub.docker.com/u/nuvo/docker-kafka


Build from Source

```bash
docker build -t nuvo/docker-kafka .
```
