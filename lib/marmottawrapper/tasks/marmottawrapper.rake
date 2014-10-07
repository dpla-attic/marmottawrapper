namespace :marmotta do

  desc "remove the marmotta jar and recreate it"
  task :clean do
    Marmottawrapper.clean
  end

  desc "rebuild the marmotta jar"
  task :build do

    dir = Marmottawrapper.build
    puts "Marmotta jar created at #{dir}"
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
