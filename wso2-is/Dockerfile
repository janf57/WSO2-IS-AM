FROM centos:7

LABEL maintainer="janavarro.fuentes@atsistemas.com"
LABEL version="0.0.1"

ENV WSO2_PRODUCT_FOLDER wso2is-5.3.0
ENV WSO2_BUNDLE_NAME wso2is-km-5.3.0
ENV WSO2_PRODUCT_WUM_FOLDER wso2is-5.3.0

ENV WSO2_VERSION 5.3.0

RUN mkdir -p /tmp/${WSO2_PRODUCT_FOLDER}-stage

ADD deps/is/packages/unzip-6.0-16.el7.x86_64.rpm /tmp/unzip-6.0-16.el7.x86_64.rpm
RUN rpm -i /tmp/unzip-6.0-16.el7.x86_64.rpm \
    && rm /tmp/unzip-6.0-16.el7.x86_64.rpm

ADD deps/is/packages/jdk-8u144-linux-x64.rpm /tmp/jdk-8u144-linux-x64.rpm
RUN rpm -i /tmp/jdk-8u144-linux-x64.rpm \
	&& ln -s /usr/java/jdk1.8.0_144 /usr/java/jdk \
    && rm /tmp/jdk-8u144-linux-x64.rpm

ENV JAVA_HOME=/usr/java/jdk1.8.0_144

# Configuracion WSO2 Identity Server

ADD deps/is/wso2is-${WSO2_VERSION}.zip /tmp/wso2is-${WSO2_VERSION}.zip 
RUN chmod +rx /tmp/wso2is-${WSO2_VERSION}.zip \
    && mv /tmp/wso2is-${WSO2_VERSION}.zip /tmp/${WSO2_PRODUCT_FOLDER}-stage/  \
    && unzip /tmp/${WSO2_PRODUCT_FOLDER}-stage/wso2is-${WSO2_VERSION}.zip -d /tmp/ \
    && mv /tmp/${WSO2_BUNDLE_NAME} /opt/${WSO2_PRODUCT_FOLDER} \
    && rm /tmp/${WSO2_PRODUCT_FOLDER}-stage/wso2is-${WSO2_VERSION}.zip

ADD deps/is/mysql-connector-java-5.1.43-bin.jar /tmp/
RUN mv /tmp/mysql-connector-java-5.1.43-bin.jar /opt/${WSO2_PRODUCT_FOLDER}/repository/components/lib/

# Create symlink
RUN ln -s /opt/${WSO2_PRODUCT_FOLDER}/repository/resources/security/ /etc/ssl

WORKDIR /opt/${WSO2_PRODUCT_FOLDER}/

EXPOSE 9443 9763 8243 8280

ENTRYPOINT /opt/${WSO2_PRODUCT_FOLDER}/bin/wso2server.sh
