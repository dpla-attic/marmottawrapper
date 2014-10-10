marmottawrapper
===============

This project creates rake tasks to easily start up [Apache Marmotta](http://marmotta.apache.org/) in Tomcat 7.

To install:

    git clone https://github.com/dpla/marmottawrapper
    cd marmottawrapper
    bundle install

* To start a Marmotta app in Tomcat 7 on port `8080`: `rake marmotta:start`
* To stop Tomcat: `rake marmotta:stop`

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
* [ ] Make Tomcat port configurable.
* [ ] Make Marmotta configurable.
* [ ] Wait for Tomcat to start before quitting `start` task.

License: Apache 2.0
