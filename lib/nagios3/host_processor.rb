require 'fileutils'
require 'net/http'
require 'logrotate'
require 'json'

module Nagios3
  
  class HostProcessor
    def run
      rotate_file
    end
    
  private
    def rotate_file
      block = Proc.new() do
        File.open(Nagios3.pid_file) do |pid_stream|
          pid = pid_stream.read().to_i()
          Process.kill("HUP", pid)
        end
      end
      
      options = { :post_rotate => block }
      LogRotate.rotate_file(Nagios3.host_perfdata_path, options)
    end
  end
  
end
