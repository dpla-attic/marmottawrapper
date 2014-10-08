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
    pid = Marmottawrapper.start
    puts "Tomcat started with PID #{pid}"
  end

  desc "Stop Marmotta/Tomcat"
  task :stop do
    pid = Marmottawrapper.stop
    puts "Tomcat/Marmotta stopped"
  end

  desc "Restart Marmotta/Tomcat"
  task :restart do
    Marmottawrapper.stop
    Marmottawrapper.start
  end
end
