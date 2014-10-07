require 'fileutils'
require 'childprocess'

class Marmottawrapper
  class << self
    def app_root
      return @app_root if @app_root
      @app_root = Rails.root if defined?(Rails) and defined?(Rails.root)
      @app_root ||= '.'
    end
    
    def marmotta_dir
      File.join(app_root, 'marmotta')
    end
    
    def build_dir
      File.join(marmotta_dir, 'target')
    end

    def clean
      system "rm -r #{build_dir}" if File.directory?(build_dir)
      build
    end

    ##
    # Build a runnable .jar file for marmotta
    def build
      Dir.chdir(marmotta_dir) {
        system "mvn clean package -Prunnable-war"
      }
    end

    ##
    # Start the Tomcat server with Marmotta on port 8080
    def start
      if pid
        if is_running?
          raise("Server is already running with PID #{pid}")
        else
          puts "Removing stale PID file at #{pid_path}"
          File.delete(pid_path)
        end
      end
      
      Dir.chdir(marmotta_dir) {
        process.start
      }

      FileUtils.makedirs(pid_dir) unless File.directory?(pid_dir)
      File::open(pid_path, 'w') do |f|
        f.puts "#{process.pid}"
      end

      process.pid
    end
    
    ##
    # Stop Tomcat/Marmotta
    def stop
      raise "No pid found in #{pid_path}" unless pid or @process
      if @process
        @process.stop
      else
        Process.kill("KILL", pid) rescue nil
      end
      
      begin
        File.delete(pid_path)
      rescue
      end
    end

    def restart
      stop
      start
    end

    def process
      @process ||= begin
                     process = ChildProcess.build('mvn', 'clean', 'tomcat7:run')
                     # TODO: When use this instead of the above
                     # java -jar #{build_dir}/marmotta-webapp-3.2.1-0.0.1-war-exec.jar
                     process.detach = true
                     process
                   end
    end

    def is_running?  
      begin
        return Process.getpgid(pid) != -1
      rescue Errno::ESRCH
        return false
      end
    end

    def pid
      File.open( pid_path ) { |f| return f.gets.to_i } if File.exist?(pid_path)
    end

    def pid_path
      @path = File.join(pid_dir, pid_file)
    end

    def pid_dir
      File.expand_path(File.join(app_root, 'tmp', 'pids'))
    end

    def pid_file
      'marmotta.pid'
    end

    def pid_file?
      File.exist?(pid_path)
    end
  end
end
