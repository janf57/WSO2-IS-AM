#FROM dcos-registry.pre.eci.geci:5000/eci/centos:7
#FROM centos:7
FROM mysql:5.5
LABEL maintainer="janavarro.fuentes@atsistemas.com"
LABEL version="0.0.1"

ADD deps/mysql/mysql.sql /docker-entrypoint-initdb.d/
