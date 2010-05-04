################################################################################
# Author: Brian J Reath
# Date: April 8, 2010
#
# Copyright (c) CCI Systems, Inc. 2010
################################################################################

module Nagios3
  class Service
    module Format
      
      def to_config
        config = "define service {\n"
        config << "\t_ID #{self.id}\n"
        config << "\thost_name #{self.host_name}\n"
        config << "\tservice_description #{self.description}\n"
        config << "\tuse #{self.use}\n"
        config << "\tcheck_command #{self.check_command}\n"
        config << "\tcontacts #{self.contacts}\n" if self.contacts
        config << "}\n"
      end
      
      def to_hash
        hash = {}
        [:id, :host_name, :description, :use, :check_command,].each do |field|
          hash[field] = self.send(field) 
        end
        hash
      end
      
      def to_s
        service = "\n"
        service << "HostName: #{self.host_name}\n" unless self.host_name.nil?
        service << "Description: #{self.description}\n" unless self.description.nil?
        service << "Use: #{self.use}\n" unless self.use.nil?
        service << "Check Command: #{self.check_command}\n" unless self.check_command.nil?
        service << "ID: #{self.id}\n" unless self.id.nil?
        service << "Current State: #{self.state}\n"
        service
      end
      
    end
  end
end
