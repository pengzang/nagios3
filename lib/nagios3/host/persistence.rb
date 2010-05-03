################################################################################
# Author: Brian J Reath
# Date: April 8, 2010
#
# Copyright (c) CCI Systems, Inc. 2010
################################################################################

module Nagios3
  class Host
    module Persistence
      
      def state
        state = nil
        regexp = /hoststatus\s*\{\s*host_name=#{self.host_name}(.*?)current_state=(\d)(.*?)\}/m
        
        File.read(Nagios3.status_path).scan(regexp) { |match| state = $2 }
        
        case state
        when "0"
          "UP"
        when "1"
          "DOWN"
        else
          "UNKNOWN"
        end
      end
      
      def save
        if Nagios3::Host.configured?(self.host_name); raise DuplicateHostError; end
        File.open(Nagios3.hosts_path, "a") { |f| f.puts(self.to_config) }
        self
      end
      
      def update
        unless Nagios3::Host.configured?(self.host_name); raise HostNotFoundError; end
        new_config = File.read(Nagios3.hosts_path).gsub(/define host\s*\{(\s*host_name\s#{self.host_name}(.*?))\}/m, self.to_config)
        File.open(Nagios3.hosts_path, "w") { |f| f.puts(new_config) }
        self
      end
      
      def destroy
        unless Nagios3::Host.configured?(self.host_name); raise HostNotFoundError; end
        new_config = File.read(Nagios3.hosts_path).gsub(/define host\s*\{(\s*host_name\s#{self.host_name}(.*?))\}/m, "")
        File.open(Nagios3.hosts_path, "w") { |f| f.puts(new_config) }
      end
      
      def self.included(klass)
        klass.extend(ClassMethods)
      end
      
      module ClassMethods
        def configured?(host_name)
          if File.read(Nagios3.hosts_path).match /define host\s*\{(\s*host_name\s#{host_name}(.*?))\}/m
            true
          else
            false
          end
        end
        
        def find(*args)
          case args.first
          when :all then find_every
          else           find_by_host_name(args.first)
          end
        end
        
      private
        def find_every
          object_cache, hosts = File.read(Nagios3.object_path), []
          object_cache.scan(/define host\s*\{(.*?)\}/m) do |match| 
            hosts << parse($1)
          end
          hosts
        end
        
        def find_by_host_name(host_name)
          objects, host = File.read(Nagios3.object_path), nil
          if objects.match /define host\s*\{(\s*host_name\s#{host_name}(.*?))\}/m
            host = parse($1)
          end
          host
        end
        
        def parse(config)
          params = { :contacts => [], :groups => [] }
          params[:name] = $1.strip if config.match param_regexp("name")
          params[:host_name] = $1.strip if config.match param_regexp("host_name")
          params[:alias] = $1.strip if config.match param_regexp("alias")
          params[:address] = $1.strip if config.match param_regexp("address")
          params[:use] = $1.strip if config.match param_regexp("use")
          params[:register] = $1.strip if config.match param_regexp("register")
          params[:contacts] = $1.strip.split(/,/) if config.match param_regexp("contacts")
          params[:groups] = $1.strip.split(/,/) if config.match param_regexp("contactgroups")
          params[:first_notification_delay] = $1.strip if config.match param_regexp("first_notification_delay")
          params[:notification_interval] = $1.strip if config.match param_regexp("notification_interval")
          params[:notification_period] = $1.strip if config.match param_regexp("notification_period")
          params[:notification_options] = $1.strip if config.match param_regexp("notification_options")

          params[:notifications_enabled] = $1 if config.match param_regexp("notifications_enabled")
          Nagios3::Host.new(params)
        end
        
        def param_regexp(name)
          /\s#{name}\s+(.+?)[\n;]/
        end
        
      end
      
    end
  end
end
