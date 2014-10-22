require 'fileutils'
require 'open-uri'
require 'zlib'
require 'archive/tar/minitar'

class Marmottawrapper

  require 'marmottawrapper/railtie' if defined?(Rails)
  Dir[File.expand_path(File.join(File.dirname(__FILE__),"marmottawrapper/tasks/*.rake"))].each { |ext| load ext } if defined?(Rake)

  class << self
    def app_root
      return @app_root if @app_root
      @app_root = Rails.root if defined?(Rails) and defined?(Rails.root)
      @app_root ||= '.'
    end
    
    def url
      @url ||= defined?(ZIP_URL) ? ZIP_URL : "https://github.com/dpla/marmottawrapper/releases/download/v0.0.5/tomcat-marmotta.tgz"
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

    def tarball
      File.join(tmp_dir, 'tomcat-marmotta.tgz')
    end

    def clean
      File.delete(tarball)
      FileUtils.rm_rf(tomcat_dir) if File.directory?(tomcat_dir)
      FileUtils.rm_rf(marmotta_dir) if File.directory?(marmotta_dir)
    end

    ##
    # Fetch the Tomcat/Marmotta distribution
    def fetch
      File.delete(tarball)
      FileUtils.makedirs(tmp_dir) unless File.directory?(tmp_dir)
      open(tarball, 'wb') do |tm|
        tm.write(open(url).read)
      end
    end

    def install
      fetch unless File.exists?(tarball)
      FileUtils.makedirs(marmotta_dir) unless File.directory?(marmotta_dir)
      tb = Zlib::GzipReader.new(File.open(tarball, 'rb'))
      Archive::Tar::Minitar.unpack(tb, app_root.to_path)
    end 

    ##
    # Start the Tomcat server with Marmotta 
    def start
      system "MARMOTTA_HOME=#{marmotta_dir} #{tomcat_dir}/bin/startup.sh"
    end
    
    ##
    # Stop Tomcat/Marmotta
    def stop
      system "MARMOTTA_HOME=#{marmotta_dir} #{tomcat_dir}/bin/shutdown.sh"
    end

  end
end
