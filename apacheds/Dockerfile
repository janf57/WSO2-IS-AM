#FROM dcos-registry.pre.eci.geci:5000/eci/centos:7
FROM centos:7

LABEL maintainer="janavarro.fuentes@atsistemas.com"
LABEL version="0.0.1"

#Instalación de ApacheDS
ENV APACHEDS_VERSION 2.0.0_M19
ENV JDK_VERSION 1.8.0_144

ENV JAVA_TOOL_OPTIONS -Duser.timezone=Europe/Madrid
ENV TZ CET-1CEST,M3.5.0,M10.5.0/3

USER root
RUN groupadd -r apacheds && useradd -r -g apacheds apacheds
COPY deps/ldap/apacheds.sh /usr/local/bin/	
COPY deps/ldap/packages/* /tmp/

# gettext
RUN rpm -i  /tmp/*.rpm

RUN chmod +x /etc/sysconfig/xinetd \
    && mkdir -p /bootstrap \
	&& ln -s /var/lib/apacheds-${APACHEDS_VERSION}/default/partitions /data \
    && chmod +x /usr/local/bin/apacheds.sh \
	&& chown -R apacheds.apacheds /data \
    && chown -R apacheds.apacheds /var/lib/apacheds-${APACHEDS_VERSION}/default/partitions \
    && mkdir ldap \
    && mkdir ldap/templates \
	&& mkdir ldap/ldifs\
	&& ln -s /usr/java/jdk${JDK_VERSION} /usr/java/jdk 

ENV JAVA_HOME=/usr/java/jdk${JDK_VERSION}

ENV PATH "$PATH:$JAVA_HOME/bin"
	
COPY deps/ldap/files/health_check.sh ldap/health_check.sh
COPY deps/ldap/files/healthchk /etc/xinetd.d/healthchk
COPY deps/ldap/ldifs/* ldap/ldifs/

RUN rm /tmp/*

RUN echo 'healthchk      11001/tcp' >> /etc/services

EXPOSE 10389 10636 11001

COPY deps/ldap/templates/* ldap/templates/

COPY deps/ldap/scripts/* ldap/

ENTRYPOINT ["ldap/start.sh"]