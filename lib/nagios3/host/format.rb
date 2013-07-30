################################################################################
# Author: Brian J Reath
# Date: May 2, 2010
#
# Copyright (c) CCI Systems, Inc. 2010
################################################################################

module Nagios3
  class Host
    module Format

      def to_config
        config = "define host {\n"
        config << "\t_ID #{self.id}\n"
        config << "\tname #{self.name}\n"
        config << "\thost_name #{self.host_name}\n"
        config << "\tuse #{self.use}\n"
        config << "\talias #{self.alias}\n"
        config << "\taddress #{self.address}\n"
        config << "\tparents #{self.parents}\n" if self.parents
        config << "\tcheck_command #{self.check_command}\n" if self.check_command
        config << "\tcheck_interval #{self.check_interval}\n" if self.check_interval
        config << "\thostgroups #{self.host_groups}\n" if self.host_groups
        config << "\tcontacts #{self.contacts}\n" if self.contacts
        config << "\tcontactgroups #{self.contact_groups}\n" if self.contact_groups
        config << "\tnotifications_enabled #{self.notifications_enabled}\n" if self.notifications_enabled
        config << "\tfirst_notification_delay #{self.first_notification_delay}\n"
        config << "\tnotification_interval #{self.notification_interval}\n"
        config << "\tnotification_period #{self.notification_period}\n"
        config << "\tnotification_options #{self.notification_options}\n"
        config << "\t_SNMPVERSION #{self.snmp_version}\n"
        config << "\t_SNMPCOMMUNITY #{self.snmp_community}\n"
        config << "}\n"
      end

      def to_hash
        hash = {}
        [:host_name, :alias, :address, :use, :register, :notifications_enabled].each do |field|
          hash[field] = self.send(field)
        end
        hash
      end

      def to_s
        host = "\n"
        host << "Name: #{@name}\n" unless @name.nil?
        host << "HostName: #{@host_name}\n" unless @host_name.nil?
        host << "Alias: #{@alias}\n" unless @alias.nil?
        host << "Address: #{@address}\n" unless @address.nil?
        host << "Use: #{@use}\n" unless @use.nil?
        host << "Register: #{@register}\n" unless @register.nil?
        host << "Log Path: #{@log_path}\n" if @register
        host << "Current State: #{current_state}\n" if @register
        host
      end

    end
  end
end
