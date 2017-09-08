FROM centos:7

LABEL maintainer="janavarro.fuentes@atsistemas.com"

ENV http_proxy http://T0000104:12345678@192.168.50.140:8080
ENV https_proxy https://T0000104:12345678@192.168.50.140:8080

ENV WSO2_PRODUCT_FOLDER wso2am-2.1.0
ENV WSO2_BUNDLE_NAME wso2am-2.1.0
ENV WSO2_PRODUCT_WUM_FOLDER wso2am-2.1.0

ENV WSO2_VERSION 2.1.0

ADD /deps/packages/unzip-6.0-16.el7.x86_64.rpm /tmp/unzip-6.0-16.el7.x86_64.rpm
RUN rpm -i /tmp/unzip-6.0-16.el7.x86_64.rpm \
    && rm /tmp/unzip-6.0-16.el7.x86_64.rpm

COPY deps/jq-linux64-1.5.zip jq-linux64-1.5.zip 
RUN unzip jq-linux64*.zip \
    && mv jq-linux64 jq \
    && mv jq /usr/bin/ \
    && chmod +x /usr/bin/jq \
    && rm jq-linux64*.zip
		
ADD /deps/packages/jdk-8u144-linux-x64.rpm /tmp/jdk-8u144-linux-x64.rpm
RUN rpm -i /tmp/jdk-8u144-linux-x64.rpm \
	&& ln -s /usr/java/jdk1.8.0_144 /usr/java/jdk \
    && rm /tmp/jdk-8u144-linux-x64.rpm

ENV JAVA_HOME=/usr/java/jdk1.8.0_144

RUN mkdir -p /tmp/${WSO2_PRODUCT_FOLDER}-stage
# Configuracion WSO2 Api Manager

ADD deps/am/wso2am-${WSO2_VERSION}.zip . 
RUN chmod +rx wso2am-${WSO2_VERSION}.zip \
    && mv ${WSO2_BUNDLE_NAME}.zip /tmp/${WSO2_PRODUCT_FOLDER}-stage/ \
    && unzip /tmp/${WSO2_PRODUCT_FOLDER}-stage/${WSO2_BUNDLE_NAME}.zip -d /opt/ \
    && rm /tmp/${WSO2_PRODUCT_FOLDER}-stage/${WSO2_BUNDLE_NAME}.zip
# Configuracion Oracle Driver

COPY deps/mysql-connector-java-5.1.43-bin.jar /opt/${WSO2_PRODUCT_FOLDER}/repository/components/lib/.

COPY deps/am/jars/*.jar /opt/${WSO2_PRODUCT_FOLDER}/repository/components/lib/

COPY deps/am/config/ /opt/${WSO2_PRODUCT_FOLDER}/ 
#COPY deps/am/config/config.zip . 
#RUN unzip -o /config.zip -d /opt/${WSO2_PRODUCT_FOLDER}/ 
#RUN rm config.zip

ENV http_proxy ""
ENV https_proxy ""
RUN unset http_proxy
RUN unset https_proxy
#Copy patches
#RUN cp /tmp/wso2am-config-stage/wso2am-config-${WSO2_ECI_CONFIG}/docker/repository/components/patches/*.jar /opt/${WSO2_PRODUCT_FOLDER}/repository/components/patches/
RUN rm -rf /tmp/wso2am-config-stage
# Create symlink
RUN ln -s /opt/${WSO2_PRODUCT_FOLDER}/repository/resources/security/ /etc/ssl
WORKDIR /opt/${WSO2_PRODUCT_FOLDER}/
EXPOSE 9444 9764 8244 8281

ENTRYPOINT /opt/${WSO2_PRODUCT_FOLDER}/bin/wso2server.sh