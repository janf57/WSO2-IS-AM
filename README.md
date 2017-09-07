### API Manager 2.1.0 - Identity Server 5.3.0 con Docker compose

![alt tag](file:///doc/am-2.1.0-is-5.3.0.jpeg)

## Pre-requisitos

 * Docker 
 * Docker compose
 * Copiar
 

Origen | Destino 
----------- | --------------------- 
servicio-config | deps
servicio-config | deps/am
servicio-config | deps/is

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