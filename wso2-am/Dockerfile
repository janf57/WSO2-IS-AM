FROM centos:7

LABEL maintainer="janavarro.fuentes@atsistemas.com"
LABEL version="0.0.1"

ENV WSO2_VERSION 2.1.0
ENV WSO2_PRODUCT wso2am
ENV WSO2_PRODUCT_FOLDER ${WSO2_PRODUCT}-${WSO2_VERSION}
ENV WSO2_BUNDLE_NAME ${WSO2_PRODUCT}-${WSO2_VERSION}
ENV WSO2_PRODUCT_WUM_FOLDER ${WSO2_PRODUCT}-${WSO2_VERSION}

ENV JDK_VERSION 1.8.0_144

ENV JAVA_TOOL_OPTIONS -Duser.timezone=Europe/Madrid
ENV TZ CET-1CEST,M3.5.0,M10.5.0/3

COPY deps/am/packages/unzip-6.0-16.el7.x86_64.rpm /tmp/unzip-6.0-16.el7.x86_64.rpm
RUN rpm -i /tmp/unzip-6.0-16.el7.x86_64.rpm \
    && rm /tmp/unzip-6.0-16.el7.x86_64.rpm

COPY deps/am/jq-linux64-1.5.zip jq-linux64-1.5.zip 
RUN unzip jq-linux64*.zip \
    && mv jq-linux64 jq \
    && mv jq /usr/bin/ \
    && chmod +x /usr/bin/jq \
    && rm jq-linux64*.zip
		
COPY deps/am/packages/jdk-8u144-linux-x64.rpm /tmp/jdk-8u144-linux-x64.rpm
RUN rpm -i /tmp/jdk-8u144-linux-x64.rpm \
	&& ln -s /usr/java/jdk${JDK_VERSION} /usr/java/jdk \
    && rm /tmp/jdk-8u144-linux-x64.rpm

ENV JAVA_HOME=/usr/java/jdk${JDK_VERSION}

RUN mkdir -p /tmp/${WSO2_PRODUCT_FOLDER}-stage

COPY deps/am/${WSO2_PRODUCT_FOLDER}.zip /tmp/${WSO2_PRODUCT_FOLDER}.zip  
RUN chmod +rx /tmp/${WSO2_PRODUCT_FOLDER}.zip \
    && unzip /tmp/${WSO2_PRODUCT_FOLDER}.zip -d /tmp/${WSO2_PRODUCT_FOLDER}-stage/ \
    && mv /tmp/${WSO2_PRODUCT_FOLDER}-stage/${WSO2_BUNDLE_NAME} /opt/${WSO2_PRODUCT_FOLDER} \
    && rm /tmp/${WSO2_PRODUCT_FOLDER}.zip
# Configuracion Oracle Driver

COPY deps/am/mysql-connector-java-5.1.43-bin.jar /opt/${WSO2_PRODUCT_FOLDER}/repository/components/lib/.

COPY deps/am/jars/*.jar /opt/${WSO2_PRODUCT_FOLDER}/repository/components/lib/

COPY deps/am/config/ /opt/${WSO2_PRODUCT_FOLDER}/ 

RUN rm -rf /tmp/${WSO2_PRODUCT}-config-stage

# Create symlink
RUN ln -s /opt/${WSO2_PRODUCT_FOLDER}/repository/resources/security/ /etc/ssl
WORKDIR /opt/${WSO2_PRODUCT_FOLDER}/
EXPOSE 9444 9764 8244 8281

ENTRYPOINT /opt/${WSO2_PRODUCT_FOLDER}/bin/wso2server.sh