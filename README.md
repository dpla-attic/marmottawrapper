marmottawrapper
===============

This project creates rake tasks to easily start up [Apache Marmotta](http://marmotta.apache.org/) in Tomcat 7.

To install:

    git clone https://github.com/dpla/marmottawrapper
    cd marmottawrapper
    bundle install

Download and install Marmotta:

    rake marmotta:fetch
	rake marmotta:install

* To start a Marmotta app in Tomcat 7 on port `8080`: `rake marmotta:start`
* To stop Tomcat: `rake marmotta:stop`


Configuration
-------------

By default, Marmotta will create all its necessary files in a `marmotta`
subdirectory of your application's root once you start it for the first time,
including sensible defaults for configuration. Configuration changes can be
made by altering `marmotta/system-config.properties` (see the
[Marmotta documentation](http://marmotta.apache.org/configuration.html)
for more details).

Use in Rails Projects
----------------------

A railtie is included to make the tasks available to Rails applications. To use
the railtie add `marmottawrapper` to your Gemfile and run `bundle install`.

`rake -T` should now reveal that the marmotta tasks are available:

    rake marmotta:fetch
	rake marmotta:install
	rake marmotta:start

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
* [ ] Wait for Tomcat to start before quitting `start` task.
* [ ] Add support for Windows.

License: Apache 2.0
