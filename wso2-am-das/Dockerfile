FROM centos:7

LABEL maintainer="janavarro.fuentes@atsistemas.com"
LABEL version="1.0.0"

ENV WSO2_VERSION 2.1.0
ENV WSO2_PRODUCT wso2am-analytics
ENV WSO2_PRODUCT_FOLDER ${WSO2_PRODUCT}-${WSO2_VERSION}
ENV WSO2_BUNDLE_NAME ${WSO2_PRODUCT}-${WSO2_VERSION}
ENV WSO2_PRODUCT_WUM_FOLDER ${WSO2_PRODUCT}-${WSO2_VERSION}

ENV JDK_VERSION 1.8.0_144

ENV JAVA_TOOL_OPTIONS -Duser.timezone=Europe/Madrid
ENV TZ CET-1CEST,M3.5.0,M10.5.0/3

COPY deps/packages/unzip-6.0-16.el7.x86_64.rpm /tmp/unzip-6.0-16.el7.x86_64.rpm
RUN rpm -i /tmp/unzip-6.0-16.el7.x86_64.rpm \
    && rm /tmp/unzip-6.0-16.el7.x86_64.rpm
	
COPY deps/packages/jdk-8u144-linux-x64.rpm /tmp/jdk-8u144-linux-x64.rpm
RUN rpm -i /tmp/jdk-8u144-linux-x64.rpm \
	&& ln -s /usr/java/jdk${JDK_VERSION} /usr/java/jdk \
    && rm /tmp/jdk-8u144-linux-x64.rpm

ENV JAVA_HOME=/usr/java/jdk${JDK_VERSION}

RUN mkdir -p /tmp/${WSO2_PRODUCT_FOLDER}-stage

COPY deps/${WSO2_PRODUCT_FOLDER}.zip /tmp/${WSO2_PRODUCT_FOLDER}.zip  
RUN chmod +rx /tmp/${WSO2_PRODUCT_FOLDER}.zip \
    && unzip /tmp/${WSO2_PRODUCT_FOLDER}.zip -d /tmp/${WSO2_PRODUCT_FOLDER}-stage/ \
    && mv /tmp/${WSO2_PRODUCT_FOLDER}-stage/${WSO2_BUNDLE_NAME} /opt/${WSO2_PRODUCT_FOLDER} \
    && rm /tmp/${WSO2_PRODUCT_FOLDER}.zip

#RUN rm /opt/${WSO2_PRODUCT_FOLDER}/repository/components/plugins/org.wso2.carbon.analytics.datasource.rdbms*.jar
COPY deps/config/ /opt/${WSO2_PRODUCT_FOLDER}/ 
 
RUN rm -rf /tmp/${WSO2_PRODUCT}-config-stage

# Create symlink
RUN ln -s /opt/${WSO2_PRODUCT_FOLDER}/repository/resources/security/ /etc/ssl

WORKDIR /opt/${WSO2_PRODUCT_FOLDER}/

EXPOSE 7613 7713 9765 9445 9613 9713

ENTRYPOINT /opt/${WSO2_PRODUCT_FOLDER}/bin/wso2server.sh