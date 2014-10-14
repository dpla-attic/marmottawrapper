require 'fileutils'

class Marmottawrapper

  require 'marmottawrapper/railtie' if defined?(Rails)

  class << self
    def app_root
      return @app_root if @app_root
      @app_root = Rails.root if defined?(Rails) and defined?(Rails.root)
      @app_root ||= '.'
    end
    
    def url
      @url ||= defined?(ZIP_URL) ? ZIP_URL : "https://github.com/dpla/marmotta-webapp/releases/download/v0.0.4/tomcat-marmotta.zip"
    end

    def marmotta_dir
      File.join(app_root, 'marmotta')
    end
    
    def tmp_dir
      File.join(app_root, 'tmp')
    end

    def tomcat_dir
      File.join(app_root, 'tomcat')
    end

    def clean
      system "rm -r #{tomcat_dir}" if File.directory?(tomcat_dir)
      system "rm -r #{tmp_dir}" if File.directory?(tmp_dir)
      system "rm -r #{marmotta_dir}" if File.directory?(marmotta_dir)
    end

    ##
    # Fetch the Tomcat/Marmotta distribution
    def fetch
      FileUtils.makedirs(tmp_dir) unless File.directory?(tmp_dir)
      FileUtils.makedirs(marmotta_dir) unless File.directory?(marmotta_dir)
      Dir.chdir(tmp_dir) {
        system "curl -L #{url} -o tomcat-marmotta.zip"
      }
    end

    def install
      fetch unless File.exists?(File.join(tmp_dir, 'tomcat-marmotta.zip'))
      system "unzip #{tmp_dir}/tomcat-marmotta.zip"
      File.delete(File.join(tmp_dir, 'tomcat-marmotta.zip'))
    end 

    ##
    # Start the Tomcat server with Marmotta 
    def start
      system "#{tomcat_dir}/bin/startup.sh"
    end
    
    ##
    # Stop Tomcat/Marmotta
    def stop
      system "#{tomcat_dir}/bin/shutdown.sh"
    end

    def restart
      stop
      sleep 2
      start
    end

  end
end
