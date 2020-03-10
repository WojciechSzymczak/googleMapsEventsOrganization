# Authorization Web App.

A small, web service allowing users to authenticate. Made for academic subject.

### Prerequisites

Used technologies:
* IntelliJ IDEA Ultimate
* Apache Tomcat 9
* Oracle Database Express Edition 18

### Installing

Download and install JDK 11+, Oracle Database 18, InteliJ IDEA and Tomcat 9.
Load project in IntelijJ IDEA.
Find file config.properties.sample and copy it as config.properties. Alter created file to match your database settings.
In InteliJ IDEA:
    1. Edit Configurations -> Add new Configuration -> Maven:
        - set Working directory
        - set Command line: clean install
    2. Edit Configurations -> Add new Configuration -> Tomcat Server -> local -> Server:
        - set Tomcat directory
        - URL: http://localhost:8080/events
        - VM options: -Dproperties_path=PROJECT_PATH\authorization-app\src\main\webapp\config\config.properties -
          where "-Dproperties_path" should bea a path to config.properties file you created earlier
        - delete everything in "Before build:" window
        Tomcat Server -> local -> Deployment:
        - make sure "AuthorizationApp:war exploded" is present
        - set application context: /events

## Built With

* [Maven](https://maven.apache.org/) - Dependency Management

## Authors

* **Wojciech Szymczak, Marcin Szymkowski**