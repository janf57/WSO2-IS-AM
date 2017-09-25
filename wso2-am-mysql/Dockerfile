FROM mysql:5.5

LABEL maintainer="janavarro.fuentes@atsistemas.com"
LABEL version="1.0.0"

ENV JAVA_TOOL_OPTIONS -Duser.timezone=Europe/Madrid
ENV TZ CET-1CEST,M3.5.0,M10.5.0/3

COPY deps/mysql/*.sql /docker-entrypoint-initdb.d/