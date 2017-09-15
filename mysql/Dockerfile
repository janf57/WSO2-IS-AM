#FROM dcos-registry.pre.eci.geci:5000/eci/centos:7
#FROM centos:7
FROM mysql:5.5
LABEL maintainer="janavarro.fuentes@atsistemas.com"
LABEL version="0.0.1"

ENV JAVA_TOOL_OPTIONS -Duser.timezone=Europe/Madrid
ENV TZ CET-1CEST,M3.5.0,M10.5.0/3

COPY deps/mysql/manageridentity.sql /docker-entrypoint-initdb.d/
COPY deps/mysql/analytics.sql /docker-entrypoint-initdb.d/
