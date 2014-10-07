marmotta-webapp
===============

This project creates rake tasks to easily start up [Apache Marmotta](http://marmotta.apache.org/) in Tomcat 7.

To install:

    git clone https://github.com/dpla/marmotta-webapp
	cd marmotta-webapp
    bundle install

* To start a Marmotta app in Tomcat 7 on port `8080`: `rake marmotta:start`

Virtual Machine
---------------
This project comes with a vagrant file that will configure a working environment
for Marmotta. To use it:

    vagrant up
    vagrant ssh
	rake marmotta:start

Marmotta should now be available on your host machine at port `8087`.

TODO:
-----
* [ ] Use a runnable/downloadable JAR file: `mvn clean package -Prunnable-war`, `java -jar target/marmotta-webapp-3.2.1-0.0.1-war-exec.jar`
* [ ] Add task to download JAR, to make this easier to use in projects.
* [ ] Make Tomcat port configurable.
* [ ] Wait for Tomcat to start before quitting `start` task.

License: Apache 2.0
