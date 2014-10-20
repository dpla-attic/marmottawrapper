namespace :marmotta do

  desc "remove the Marmotta data directory and recreate it"
  task :clean do
    Marmottawrapper.clean
  end

  desc "fetch the Marmotta and Tomcat distribution"
  task :fetch do
    Marmottawrapper.fetch
  end

  desc "Install the Marmotta and Tomcat distribution"
  task :install do
    Marmottawrapper.install
  end

  desc "Start Marmotta/Tomcat"
  task :start do
    Marmottawrapper.start
  end

  desc "Stop Marmotta/Tomcat"
  task :stop do
    Marmottawrapper.stop
  end

  desc "Restart Marmotta/Tomcat"
  task :restart do
    Marmottawrapper.stop
    sleep 2
    Marmottawrapper.start
  end

end
