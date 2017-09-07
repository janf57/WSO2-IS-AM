#FROM dcos-registry.pre.eci.geci:5000/eci/centos:7
FROM centos:7

LABEL maintainer="janavarro.fuentes@atsistemas.com"

ENV http_proxy http://T0000104:12345678@192.168.50.140:8080
ENV https_proxy https://T0000104:12345678@192.168.50.140:8080

# Instalacion de entorno
#RUN adduser sqlldap
#USER sqlldap
# unzip
ADD /deps/unzip-6.0-16.el7.x86_64.rpm /tmp/unzip-6.0-16.el7.x86_64.rpm
RUN rpm -i /tmp/unzip-6.0-16.el7.x86_64.rpm \
   && rm /tmp/unzip-6.0-16.el7.x86_64.rpm

#jdk 1.8
ADD /deps/jdk-8u144-linux-x64.rpm /tmp/jdk-8u144-linux-x64.rpm
RUN rpm -i /tmp/jdk-8u144-linux-x64.rpm \
	&& ln -s /usr/java/jdk1.8.0_144 /usr/java/jdk \
    && rm /tmp/jdk-8u144-linux-x64.rpm

ENV JAVA_HOME=/usr/java/jdk1.8.0_144

ENV PATH "$PATH:$JAVA_HOME/bin"

# jq
COPY deps/jq-linux64-1.5.zip jq-linux64-1.5.zip 
RUN unzip jq-linux64*.zip \
   && mv jq-linux64 jq \
   && mv jq /usr/bin/ \
   && chmod +x /usr/bin/jq \
   && rm jq-linux64*.zip

# Instalación de MySQL
ARG PACKAGE_URL=mysql-community-server-minimal-5.5.57-2.el7.x86_64.rpm
ARG PACKAGE_URL_SHELL=mysql-shell-1.0.9-1.el7.x86_64.rpm

ADD deps/mysql/RPM-GPG-KEY-mysql /tmp/RPM-GPG-KEY-mysql
ADD deps/mysql/$PACKAGE_URL /tmp/$PACKAGE_URL
ADD deps/mysql/$PACKAGE_URL_SHELL /tmp/$PACKAGE_URL_SHELL

# Install server
RUN groupadd -r mysql && useradd -r -g mysql mysql
RUN rpmkeys --import /tmp/RPM-GPG-KEY-mysql \
  && yum install -y localinstall /tmp/$PACKAGE_URL $PACKAGE_URL_SHELL libpwquality \
  && yum clean all \
  && mkdir /docker-entrypoint-initdb.d

VOLUME /var/lib/mysql

RUN rm /tmp/$PACKAGE_URL
RUN rm /tmp/RPM-GPG-KEY-mysql
RUN mkdir mysql 
COPY deps/mysql/docker-entrypoint.sh mysql/entrypoint.sh
COPY deps/mysql/healthcheck.sh mysql/healthcheck.sh

USER mysql:mysql
RUN chown -R mysql /var/lib/mysql \
  && chgrp -R mysql /var/lib/mysql
#ENTRYPOINT ["mysql/entrypoint.sh"]
#HEALTHCHECK CMD mysql/healthcheck.sh
EXPOSE 3306
#CMD ["mysqld"]

#Instalación de ApacheDS
USER root
RUN groupadd -r apacheds && useradd -r -g apacheds apacheds
ADD deps/ldap/apacheds.sh /usr/local/bin/	

# gettext
ADD deps/ldap/gettext-0.18.2.1-4.el7.x86_64.rpm /tmp/gettext-0.18.2.1-4.el7.x86_64.rpm
RUN yum -y localinstall /tmp/gettext-0.18.2.1-4.el7.x86_64.rpm \
   && rm -rf /tmp/gettext-0.18.2.1-4.el7.x86_64.rpm
   
# openldap
ADD deps/ldap/openldap-clients-2.4.40-13.el7.x86_64.rpm /tmp/openldap-clients-2.4.40-13.el7.x86_64.rpm
RUN yum -y localinstall /tmp/openldap-clients-2.4.40-13.el7.x86_64.rpm \
   && rm -rf /tmp/openldap-clients-2.4.40-13.el7.x86_64.rpm

# xinet
ADD deps/ldap/xinetd-2.3.15-13.el7.x86_64.rpm /tmp/xinetd-2.3.15-13.el7.x86_64.rpm
RUN yum -y localinstall /tmp/xinetd-2.3.15-13.el7.x86_64.rpm \
   && rm -rf /tmp/xinetd-2.3.15-13.el7.x86_64.rpm \
   && chmod +x /etc/sysconfig/xinetd


ADD deps/ldap/apacheds-2.0.0-M19-x86_64.rpm /tmp/apacheds-2.0.0-M19-x86_64.rpm
RUN yum -y localinstall /tmp/apacheds-2.0.0-M19-x86_64.rpm \
    && rm -rf /tmp/apacheds-2.0.0-M19-x86_64.rpm \
    && mkdir -p /bootstrap \
	&& ln -s /var/lib/apacheds-2.0.0_M19/default/partitions /data \
    && chmod +x /usr/local/bin/apacheds.sh \
	&& chown -R apacheds.apacheds /data \
    && chown -R apacheds.apacheds /var/lib/apacheds-2.0.0_M19/default/partitions
	
RUN mkdir ldap \
    && mkdir ldap/templates \
	&& mkdir ldap/ldifs

COPY deps/ldap/files/health_check.sh ldap/health_check.sh
COPY deps/ldap/files/healthchk /etc/xinetd.d/healthchk
COPY deps/ldap/ldifs/* ldap/ldifs/

RUN echo 'healthchk      11001/tcp' >> /etc/services

EXPOSE 10389 10636 11001

COPY deps/ldap/templates/* ldap/templates/

COPY deps/ldap/scripts/* ldap/

ENTRYPOINT ["ldap/start.sh"]