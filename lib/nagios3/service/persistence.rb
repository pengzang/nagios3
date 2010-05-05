################################################################################
# Author: Brian J Reath
# Date: May 3, 2010
#
# Copyright (c) CCI Systems, Inc. 2010
################################################################################

module Nagios3
  class Service
    module Persistence
      
      def state
        state = nil
        regexp = /servicestatus\s*\{\s*host_name=#{self.host_name}\s+service_description=#{self.description}(.*?)current_state=(\d)(.*?)\}/m
        
        File.read(Nagios3.status_path).scan(regexp) do |match|
         state = $2
        end

        case state
        when "0"
         "OK"
        when "1"
          "WARN"
        when "2"
          "CRITICAL"
        else
          "UNKNOWN"
        end
      end
      
      def save
        if Nagios3::Service.configured?(self.id)
          raise DuplicateServiceError
        end
        File.open(Nagios3.services_path, "a") { |f| f.puts(self.to_config) }
        self
      end
      
      def update
        unless Nagios3::Service.configured?(self.id); raise HostNotFoundError; end
        new_config = File.read(Nagios3.services_path).gsub(
          self.class.object_regexp(self.id), self.to_config
        )
        File.open(Nagios3.services_path, "w") { |f| f.puts(new_config) }
        self
      end
      
      def update_attributes(params)
        params.each do |key, value|
          method = (key.to_s + "=").to_sym
          self.send(method, value) if self.respond_to?(method)
        end
        self.update
      end
      
      def destroy
        unless Nagios3::Service.configured?(self.id); raise HostNotFoundError; end
        new_config = File.read(Nagios3.services_path).gsub(
          self.class.object_regexp(self.id), ""
        )
        File.open(Nagios3.services_path, "w") { |f| f.puts(new_config) }
        self
      end
      
      def self.included(klass)
        klass.extend(ClassMethods)
      end
      
      module ClassMethods
        def configured?(id)
          if File.read(Nagios3.services_path).match(object_regexp(id))
            true
          else
            false
          end
        end
        
        def find(*args)
          case args.first
          when :all then find_every
          else find_by_id(args.first)
          end
        end
        
        def object_regexp(id)
          /define service\s*\{([^\{]*?_ID\s+#{id}[^\}]*?)\}\s/m
        end
        
      private
        def find_every
          object_cache, services = File.read(Nagios3.services_path), []
          object_cache.scan(/define service\s*\{(.*?)\}/m) do |match| 
            services << parse($1)
          end
          services
        end
        
        def find_by_id(id)
          object_cache, service = File.read(Nagios3.services_path), nil
          if object_cache.match(object_regexp(id))
            service = parse($1)
          end
          service
        end
        
        def parse(config)
          params = {}
          params[:name] = $1.strip if config.match param_regexp("name")
          params[:host_name] = $1.strip if config.match param_regexp("host_name")
          params[:description] = $1.strip if config.match param_regexp("service_description")
          params[:use] = $1.strip if config.match param_regexp("use")
          params[:check_command] = $1.strip if config.match param_regexp("check_command")
          params[:register] = $1.strip if config.match param_regexp("register")
          params[:log_path] = @log_path
          params[:status_path] = "#{@cache_path}/status.dat"
          params[:config_path] = @custom_services_config_path
          params[:rrd] = $1.strip if config.match param_regexp("_RRD")
          params[:id] = $1.strip if config.match param_regexp("_ID")
          Service.new(params)
        end
        
        def param_regexp(name)
          /\s#{name}\s+(.+?)[\n;]/
        end
        
      end
      
    end
  end
end
