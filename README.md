### API Manager 2.1.0 - Identity Server 5.3.0 con Docker compose

![alt tag](https://github.com/janf57/WSO2-IS-AM/blob/master/doc/am-2.1.0-is-5.3.0.jpeg)

## Pre-requisitos

 * Docker 
 * Docker compose
 * Copiar
 

Origen | Destino 
-------- | -------------- 
curl -C - -L -O -# -H "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u144-b01/090f390dda5b47b9b721c7dfaa008135/jdk-8u144-linux-x64.rpm | wso2-am/deps/am/packages
curl -C - -L -O -# -H "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u144-b01/090f390dda5b47b9b721c7dfaa008135/jdk-8u144-linux-x64.rpm | wso2-is/deps/is/packages
curl -C - -L -O -# -H "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u144-b01/090f390dda5b47b9b721c7dfaa008135/jdk-8u144-linux-x64.rpm | wso2-das/deps/das/packages
curl -C - -L -O -# -H "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u144-b01/090f390dda5b47b9b721c7dfaa008135/jdk-8u144-linux-x64.rpm | apacheds/deps/ldap/packages
curl -O  -A "testuser" -H "Referer: http://connect.wso2.com/wso2/getform/reg/new_product_download" https://product-dist.wso2.com/products/api-manager/2.1.0/wso2am-2.1.0.zip | wso2-am/deps/am
http://product-dist.wso2.com/downloads/api-manager/2.1.0/identity-server/wso2is-km-5.3.0.zip | wso2-is/deps/is
curl -O  -A "testuser" -H "Referer: http://connect.wso2.com/wso2/getform/reg/new_product_download" https://product-dist.wso2.com/products/data-analytics-server/3.1.0/wso2das-3.1.0.zip | wso2-das/deps/das

#### Como lanzarlo

```docker-compose pull```

```docker-compose up ```

Esto despliega lo siguiente,

* **[Consul][consul]** Agrupa multiples componentes los utilizados son :
    * **Detección de fallos** Realiza un chequeo de salud identificando posibles fallos.
    * **Almacenamiento KV** Almacenamiento de pares key/value para configuración dinámica.  
* **[Mysql server][mysql]** Sistema de gestión de bases de datos relacional, cargada con las bd apimdb, userdb, regdb, necesarias para la ejecución de productos del ecosistema de WSO2.
* **[ApacheDS][apacheds]** Servidor de servicios de directorio.
* **[API Manager][apim]** Solución que permite la creación, publicación y gestión de todos lo relacionados con las API's y su ciclo de vida. Contiene:
    * **Publisher**: Aplicación que permite publicar APIs, gestionarlas y documentarlas.
    * **Store**: Aplicación utilizada como catálogo de APIs que permite la suscripción a las APIs para las cuales tenemos permiso.
    * **Gateway**: Actúa como un proxy que intercepta las peticiones entrantes y aplica políticas de seguridad y disponibilidad.
* **[Identity Server][identity]** Producto que actua como **Key Manager** del API Manager,  gestiona la seguridad y los tokens de acceso.
* **[Data analitycs][analytics]** Producto que permite el análisis de flujos de datos procedentes del API Manager.

[apim]: https://wso2.com/api-management/
[consul]: https://www.consul.io/
[mysql]: https://www.mysql.com/
[identity]: https://wso2.com/identity-and-access-management
[analytics]: https://wso2.com/analytics
[apacheds]: http://directory.apache.org/apacheds/

#### Como probar

Añadir las siguientes entradas a /etc/hosts o a C:\Windows\System32\drivers\etc\hosts
```
127.0.0.1 api-manager is-key-manager apim_db consul
```

#### Como acceder al entorno
**Consul**
```
http://consul:8500
```

**Publisher**
```
https://api-manager:9444/publisher
```

**Store**
```
https://api-manager:9444/store/
```

**Gateway Manager**
```
https://api-manager:9444/carbon/
```