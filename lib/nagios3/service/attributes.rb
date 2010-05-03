################################################################################
# Author: Brian J Reath
# Date: May 3, 2010
#
# Copyright (c) CCI Systems, Inc. 2010
################################################################################

module Nagios3
  class Service
    module Attributes
      
      attr_accessor :id, :host_name, :host_group_name, :description, :use
      attr_accessor :service_groups
      
      attr_accessor :check_command, :check_interval, :retry_interval
      attr_accessor :max_check_attempts, :check_period
      
      attr_accessor :contacts, :contact_groups, :notification_options
      attr_accessor :first_notification_delay, :notification_interval
      attr_accessor :notification_period, :notifications_enabled
      
      def self.included(klass)
         klass.extend(ClassMethods)
       end
      
      module ClassMethods
      end
      
    end
  end
end
