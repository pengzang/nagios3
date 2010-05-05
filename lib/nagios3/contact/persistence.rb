################################################################################
# Author: Brian J Reath
# Date: April 8, 2010
#
# Copyright (c) CCI Systems, Inc. 2010
################################################################################

module Nagios3
  class Contact
    module Persistence
      
      def save
        if Nagios3::Contact.configured?(self.id); raise DuplicateContactError; end
        File.open(Nagios3.contacts_path, "a") { |f| f.puts(self.to_config) }
        self
      end
      
      def update
        unless Nagios3::Contact.configured?(self.id); raise ContactNotFoundError; end
        new_config = File.read(Nagios3.contacts_path).gsub(
          self.class.object_regexp(id), self.to_config
        )
        File.open(Nagios3.contacts_path, "w") { |f| f.puts(new_config) }
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
        unless Nagios3::Contact.configured?(self.id); raise ContactNotFoundError; end
        new_config = File.read(Nagios3.contacts_path).gsub(
          self.class.object_regexp(self.id), ""
        )
        File.open(Nagios3.contacts_path, "w") { |f| f.puts(new_config) }
        self
      end
      
      def self.included(klass)
        klass.extend(ClassMethods)
      end
      
      module ClassMethods
        def configured?(id)
          config = File.read(Nagios3.contacts_path)
          if config.match(object_regexp(id))
            true
          else
            false
          end
        end
        
        def find(*args)
          case args.first
          when :all then find_every
          else           find_by_id(args.first)
          end
        end
        
        def object_regexp(id)
          /define contact\s*\{([^\{]*?_ID\s*#{id}[^\}]*?)\}\s/m
        end
        
      private
        def find_every
          object_cache, contacts = File.read(Nagios3.contacts_path), []
          object_cache.scan(/define contact\s*\{(.*?)\}/m) do |match| 
            contacts << parse($1)
          end
          contacts
        end
        
        def find_by_id(id)
          objects, contact = File.read(Nagios3.contacts_path), nil
          if objects.match(object_regexp(id))
            contact = parse($1)
          end
          contact
        end
        
        def parse(config)
          params = { :groups => [] }
          params[:id] = $1.strip if config.match param_regexp("_ID")
          params[:name] = $1.strip if config.match param_regexp("contact_name")
          params[:alias] = $1.strip if config.match param_regexp("alias")
          params[:groups] = $1.strip.split(/,/) if config.match param_regexp("contactgroups")
          params[:email] = $1.strip if config.match param_regexp("email")
          params[:pager] = $1.strip if config.match param_regexp("pager")
          params[:mobile] = $1.strip if config.match param_regexp("address1")
          params[:host_notification_commands] = $1.strip if config.match param_regexp("host_notification_commands")
          params[:host_notification_period] = $1.strip if config.match param_regexp("host_notification_period")
          params[:host_notification_options] = $1.strip if config.match param_regexp("host_notification_options")
          params[:host_notifications_enabled] = $1.strip if config.match param_regexp("host_notifications_enabled")
          params[:service_notification_commands] = $1.strip if config.match param_regexp("service_notification_commands")
          params[:service_notification_period] = $1.strip if config.match param_regexp("service_notification_period")
          params[:service_notification_options] = $1.strip if config.match param_regexp("service_notification_options")
          params[:service_notifications_enabled] = $1.strip if config.match param_regexp("service_notifications_enabled")
          Nagios3::Contact.new(params)
        end
        
        def param_regexp(name)
          /\s#{name}\s+(.+?)[\n;]/
        end
        
      end
      
    end
  end
end
