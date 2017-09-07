### API Manager 2.1.0 - Identity Server 5.3.0 con Docker compose

![alt tag](https://github.com/janf57/WSO2-IS-AM/blob/master/doc/am-2.1.0-is-5.3.0.jpeg)

## Pre-requisitos

 * Docker 
 * Docker compose
 * Copiar
 

Origen | Destino 
-------- | -------------- 
java_jdk-1.8.zip | deps
wso2am-2.1.0.2.zip | deps/am
wso2is-5.3.0.2.zip | deps/is

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