require 'net/http'
require 'logger'
require 'logrotate'
require 'zlib'

module Nagios3
  #[SERVICEPERFDATA]\t$TIMET$\t$HOSTNAME$\t$SERVICEDESC$\t$_SERVICE_ID$\t$_SERVICERRD$\t$_SERVICERRDFILE$\t$_SERVICESTATS$\t$SERVICEEXECUTIONTIME$\t$SERVICELATENCY$\t$SERVICEOUTPUT$\t$SERVICEPERFDATA$
  class ServicePerfdataProcessor
  
    def initialize(options = {})
      @file_path = options[:file_path]
      @entries = []
    end
  
    def run
      parse_file
      clear_file
      
      
      
      # Do a logrotate on the file
      # Gather data and compress
      # Send to remote monitoring server (with extensive error checking)
      
      # logrotate gem
      # Net::HTTP
      # Zlib::Defalte
      # logger STDLIB
    end
  
  private

    def parse_file
      File.open(@file_path) do |f|
        f.each { |line| @entries << parse(line) }
      end
    end
  
    def clear_file
      File.open(@file_path, "w") do |f|
        f.print ""
      end
    end

    def parse(line)
      if line =~ /^\[SERVICEPERFDATA\]([^\|]*)\|([^\|]*)\|([^\|]*)\|([^\|]*)\|([^\|]*)\|([^\|]*)\|([^\|]*)\|([^\|]*)\|([^\|]*)\|([^\|]*)\|([^\|]*)$/
        perf_hash = { :time => $1, :host => $2, :service => $3, :id => $4, :rrd => $5, :rrd_file => $6,
                      :stats => $7, :execution_time => $8, :latency => $9, :output => $10, :perfdata => $11 }
      end
    end
  
  end
end