### API Manager 2.1.0 - Identity Server 5.3.0 con Docker compose

![alt tag](https://github.com/janf57/WSO2-IS-AM/blob/master/doc/am-2.1.0-is-5.3.0.jpeg)

## Pre-requisitos

 * Docker 
 * Docker compose
 * Copiar
 

Origen | Destino 
-------- | -------------- 
http://download.oracle.com/otn-pub/java/jdk/8u144-b01/090f390dda5b47b9b721c7dfaa008135/jdk-8u144-linux-x64.rpm | deps
https://product-dist.wso2.com/products/api-manager/2.1.0/wso2am-2.1.0.zip | deps/am
https://product-dist.wso2.com/products/identity-server/5.3.0/wso2is-5.3.0.zip | deps/is

#### Como lanzarlo

```docker-compose pull```

```docker-compose up --build -d ```

Esto despliega lo siguiente,

* Mysql server (contenedor) con apimdb, userdb, regdb, y ApacheDS con
* APIM Contenedor
* IS (Contenedor)

#### Como probar


#### Como acceder al entorno

Publisher

```
https://localhost:9444/publisher
```

Store

```
https://localhost:9444/store/
```


Gateway Manager

```
https://localhost:9444/carbon/
```