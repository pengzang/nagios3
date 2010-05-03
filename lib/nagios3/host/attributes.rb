################################################################################
# Author: Brian J Reath
# Date: April 8, 2010
#
# Copyright (c) CCI Systems, Inc. 2010
################################################################################

module Nagios3
  class Host
    module Attributes
      
      attr_accessor :id, :host_name, :alias, :address, :use
      attr_accessor :host_groups
      
      attr_accessor :check_command, :check_interval, :retry_interval
      attr_accessor :max_check_attempts, :check_period
      
      attr_accessor :contacts, :contact_groups, :notification_options
      attr_accessor :first_notification_delay, :notification_interval
      attr_accessor :notification_period, :notifications_enabled
      
      attr_accessor :parents, :process_perf_data
      
      attr_accessor :snmp_version, :snmp_community
      
      def self.included(klass)
        klass.extend(ClassMethods)
      end
      
      module ClassMethods
      end
      
    end
  end
end
