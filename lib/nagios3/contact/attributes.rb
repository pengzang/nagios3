################################################################################
# Author: Brian J Reath
# Date: April 8, 2010
#
# Copyright (c) CCI Systems, Inc. 2010
################################################################################

module Nagios3
  class Contact
    module Attributes
      
      attr_accessor :id, :name, :alias, :groups, :email, :pager
      attr_accessor :mobile, :address2, :address3, :address4
      
      attr_accessor :host_notification_commands, :host_notification_period
      attr_accessor :host_notification_options, :host_notifications_enabled
      
      attr_accessor :service_notification_commands, :service_notification_period
      attr_accessor :service_notification_options, :service_notifications_enabled
      
      def self.included(klass)
         klass.extend(ClassMethods)
       end
      
      module ClassMethods
      end
      
    end
  end
end
