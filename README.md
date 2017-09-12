### API Manager 2.1.0 - Identity Server 5.3.0 con Docker compose

![alt tag](https://github.com/janf57/WSO2-IS-AM/blob/master/doc/am-2.1.0-is-5.3.0.jpeg)

## Pre-requisitos

 * Docker 
 * Docker compose
 * Copiar
 

Origen | Destino 
-------- | -------------- 
http://download.oracle.com/otn-pub/java/jdk/8u144-b01/090f390dda5b47b9b721c7dfaa008135/jdk-8u144-linux-x64.rpm | wso2-am/deps/am/packages
http://download.oracle.com/otn-pub/java/jdk/8u144-b01/090f390dda5b47b9b721c7dfaa008135/jdk-8u144-linux-x64.rpm | wso2-is/deps/is/packages
http://download.oracle.com/otn-pub/java/jdk/8u144-b01/090f390dda5b47b9b721c7dfaa008135/jdk-8u144-linux-x64.rpm | apacheds/deps/ldap/packages
https://product-dist.wso2.com/products/api-manager/2.1.0/wso2am-2.1.0.zip | wso2-am/deps/am
https://product-dist.wso2.com/products/identity-server/5.3.0/wso2is-5.3.0.zip | wso2-is/deps/is

#### Como lanzarlo

```docker-compose pull```

```docker-compose up ```

Esto despliega lo siguiente,

* Mysql server con apimdb, userdb, regdb
* ApacheDS con
* APIM 
* IS 

#### Como probar

Añadir las siguientes entradas a /etc/hosts o a C:\Windows\System32\drivers\etc\hosts
```
127.0.0.1 api-manager is-key-manager apim_db
```

#### Como acceder al entorno

Publisher

```
https://api-manager:9444/publisher
```

Store

```
https://api-manager:9444/store/
```


Gateway Manager

```
https://api-manager:9444/carbon/
```