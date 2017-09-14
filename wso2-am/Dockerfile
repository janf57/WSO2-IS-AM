FROM centos:7

LABEL maintainer="janavarro.fuentes@atsistemas.com"
LABEL version="0.0.1"

ENV WSO2_VERSION 2.1.0
ENV WSO2_PRODUCT_FOLDER wso2am-${WSO2_VERSION}
ENV WSO2_BUNDLE_NAME wso2am-${WSO2_VERSION}
ENV WSO2_PRODUCT_WUM_FOLDER wso2am-${WSO2_VERSION}

ENV JDK_VERSION 1.8.0_144

COPY deps/am/packages/unzip-6.0-16.el7.x86_64.rpm /tmp/unzip-6.0-16.el7.x86_64.rpm
RUN rpm -i /tmp/unzip-6.0-16.el7.x86_64.rpm \
    && rm /tmp/unzip-6.0-16.el7.x86_64.rpm

COPY wso2-am/deps/jq-linux64-1.5.zip jq-linux64-1.5.zip 
RUN unzip jq-linux64*.zip \
    && mv jq-linux64 jq \
    && mv jq /usr/bin/ \
    && chmod +x /usr/bin/jq \
    && rm jq-linux64*.zip
		
COPY wso2-am/deps/am/packages/jdk-8u144-linux-x64.rpm /tmp/jdk-8u144-linux-x64.rpm
RUN rpm -i /tmp/jdk-8u144-linux-x64.rpm \
	&& ln -s /usr/java/jdk${JDK_VERSION} /usr/java/jdk \
    && rm /tmp/jdk-8u144-linux-x64.rpm

ENV JAVA_HOME=/usr/java/jdk${JDK_VERSION}

RUN mkdir -p /tmp/${WSO2_PRODUCT_FOLDER}-stage
# Configuracion WSO2 Api Manager

COPY wso2-am/deps/am/wso2am-${WSO2_VERSION}.zip . 
RUN chmod +rx wso2am-${WSO2_VERSION}.zip \
    && mv ${WSO2_BUNDLE_NAME}.zip /tmp/${WSO2_PRODUCT_FOLDER}-stage/ \
    && unzip /tmp/${WSO2_PRODUCT_FOLDER}-stage/${WSO2_BUNDLE_NAME}.zip -d /opt/ \
    && rm /tmp/${WSO2_PRODUCT_FOLDER}-stage/${WSO2_BUNDLE_NAME}.zip
# Configuracion Oracle Driver

COPY wso2-am/deps/mysql-connector-java-5.1.43-bin.jar /opt/${WSO2_PRODUCT_FOLDER}/repository/components/lib/.

COPY wso2-am/deps/am/jars/*.jar /opt/${WSO2_PRODUCT_FOLDER}/repository/components/lib/

COPY wso2-am/deps/am/config/ /opt/${WSO2_PRODUCT_FOLDER}/ 

RUN rm -rf /tmp/wso2am-config-stage

# Create symlink
RUN ln -s /opt/${WSO2_PRODUCT_FOLDER}/repository/resources/security/ /etc/ssl
WORKDIR /opt/${WSO2_PRODUCT_FOLDER}/
EXPOSE 9444 9764 8244 8281

ENTRYPOINT /opt/${WSO2_PRODUCT_FOLDER}/bin/wso2server.sh