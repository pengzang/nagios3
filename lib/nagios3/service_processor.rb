require 'net/http'
require 'logrotate'
require 'json'

module Nagios3
  
  class ServiceProcessor
    def run
      rotate_file
      perfdata = parse_files
      send_data(perfdata)
      remove_files
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
      LogRotate.rotate_file(Nagios3.service_perfdata_path, options)
    end
    
    def parse_files
      entries, perfdata = perfdata_files, []
      entries.each do |entry|
        File.open(entry) do |f|
          f.each { |line| perfdata << parse(line) }
        end
      end
      perfdata
    end
    
    def perfdata_files
      d = Dir.new(File.dirname(Nagios3.service_perfdata_path))
      entries = d.entries
      entries.delete_if { |entry| !(entry =~ /^service-perfdata\.\d+$/) }
      entries.map! { |entry| File.join(d.path, entry) }
      entries
    end
    
    def send_data(perfdata)
      uri = URI.parse(Nagios3.service_perfdata_url)
      body = perfdata.to_json
      headers = {
        'Content-Type' => 'application/json',
        'Content-Length' => body.size.to_s
      }
      
      request = Net::HTTP::Post.new(uri.path, headers)
      http = Net::HTTP.new(uri.host, uri.port)
      
      timeout(10) do
        response = http.request(request, body)
      end
    end
    
    def remove_files
      perfdata_files.each { |entry| File.delete(entry) }
    end
    
    def parse(line)
      if line =~ /^\[SERVICEPERFDATA\]([^\|]*)\|([^\|]*)\|([^\|]*)\|([^\|]*)\|([^\|]*)\|([^\|]*)\|([^\|]*)\|([^\|]*)$/
        perf_hash = { 
          :time => $1, :id => $2, :host => $3, :service => $4,
          :execution_time => $5, :latency => $6, :output => $7,
          :perfdata => $8
        }
      end
    end
    
  end
  
end