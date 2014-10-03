marmotta-webapp
===

This is just a convenience Maven project to easily start up [Apache Marmotta](http://marmotta.apache.org/) in Tomcat 7 and to package an easily runnable JAR file.

* To start a foreground Marmotta app in Tomcat 7: `mvn clean tomcat7:run`

TODO:
* [ ] build a runnable JAR file: `mvn clean package -Prunnable-war`
* [ ] Start a built runnable JAR: `java -jar target/marmotta-webapp-3.2.1-0.0.1-war-exec.jar`

License: Apache 2.0