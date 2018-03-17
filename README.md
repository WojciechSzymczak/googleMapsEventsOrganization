# Events Organisation Web App with Google Maps.

A small, web service allowing users to organize events with Google Maps.


### Prerequisites

Used technologies: 
* [NetBeans IDE 8.2](https://netbeans.org)
* [Maven 4.31.1](https://maven.apache.org)
* [MySQL Server 5.7](https://dev.mysql.com/downloads/mysql/)
* [MySQL Workbench 6.3 CE](https://dev.mysql.com/downloads/workbench/)
* [Apache Tomcat 8.5.28](https://tomcat.apache.org)

Used dependencies:
* [mysql-connector-java-8.0.9-rc.jar](https://mvnrepository.com/artifact/mysql/mysql-connector-java)
* [javaee-web-api-7.0.jar](https://mvnrepository.com/artifact/javax/javaee-web-api)
* [jstl-1.2.jar](https://mvnrepository.com/artifact/jstl/jstl)
* [javax.faces-2.2.7.jar](https://mvnrepository.com/artifact/org.glassfish/javax.faces)
* [JSON In Java » 20180130](https://mvnrepository.com/artifact/org.json/json/20180130)

### Installing

For Windows:

First we need to install Tomcat. Download Tomcat and then unpack it to some convenient location. 
There are some files ought to be altered to make our server running properly.

1. Download mysql-connector-java-8.0.9-rc.jar and put it into $CATALINA_HOME/lib, where $CATALINA_HOME represents the root of your Tomcat installation.

2. Insert line below to $CATALINA_HOME/conf/tomcat-users.xml between <tomcat-users ...>...\</tomcat-users>. You will use this credentials to run your project from IDE. 
Username and password given below are just example, you should consider using stronger ones to secure your application. 

```
<user password="tomcat-user" roles="manager-script,admin" username="tomcat-user"/>
```

3. Insert line below to $CATALINA_HOME/conf/context.xml between \<Context>...\</Context>.

```  
<ResourceLink name="jdbc/MySqlDS"
                global="jdbc/MyDB"
                auth="Container"
                type="javax.sql.DataSource" />
```

4. Insert line below to $CATALINA_HOME/conf/server.xml between \<GlobalNamingResources>...\</GlobalNamingResources>.

```
<Resource name="jdbc/MyDB"
      global="jdbc/MyDB" 
      auth="Container" 
      type="javax.sql.DataSource" 
      driverClassName="com.mysql.cj.jdbc.Driver" 
      url="jdbc:mysql://localhost:3306/events?useLegacyDatetimeCode=false&amp;serverTimezone=UTC&amp;verifyServerCertificate=false&amp;useSSL=true" 
      username="root" 
      password="root123"      
      maxActive="100" 
      maxIdle="20" 
      minIdle="5" 
      maxWait="10000"/>
```

5. Insert line below into $CATALINA_HOME/conf/server.xml between <Realm ...>...\</Realm>.

```
<Realm className="org.apache.catalina.realm.JDBCRealm"
        driverName="com.mysql.cj.jdbc.Driver"
        connectionURL="jdbc:mysql://localhost:3306/events?user=root&amp;password=root123&amp;useLegacyDatetimeCode=false&amp;serverTimezone=UTC&amp;verifyServerCertificate=false&amp;useSSL=true"
        userTable="users" userNameCol="user_name" userCredCol="user_pass"
        userRoleTable="user_roles" roleNameCol="role_name"
      />
```

6. Obtaining Google Maps Api Key:

Full proces description:
[https://developers.google.com/maps/documentation/javascript/get-api-key]

Paste the key to googleMapsApiKey.txt. Place file in /WEB-INF/public_keys folder.

7. Start NetBeans and perform following tasks:

```
a. Open Services tab,
b. Right-click on Servers -> Add Server...,
c. Choose Server: Apache Tomcat or TomEE,
d. Server Location: Browse... -> Point to your $CATALINA_HOME and click Open...,
e. Enter credentials: Username: tomcat-user, password: tomcat-user as mentioned earlier,
f. Click Finish,
g. Right-click on the project -> Clean,
h. Right-click on the project -> Build with Dependencies,
i. Right-click on the project -> Run.
```

Your local copy of application should work now.

## Built With

* [Maven](https://maven.apache.org/) - Dependency Management

## Authors

* **Wojciech Szymczak**