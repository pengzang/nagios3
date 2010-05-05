################################################################################
# Author: Brian J Reath
# Date: April 8, 2010
#
# Copyright (c) CCI Systems, Inc. 2010
################################################################################

require 'nagios3/contact/attributes'
require 'nagios3/contact/persistence'
require 'nagios3/contact/format'

module Nagios3
  class Contact
    
    include Nagios3::Contact::Attributes
    include Nagios3::Contact::Format
    include Nagios3::Contact::Persistence
    
    def initialize(params = {})
      options = {
        :host_notification_commands => 'notify-host-by-email',
        :service_notification_commands => 'notify-service-by-email',
        :host_notification_period => '24x7',
        :service_notification_period => '24x7',
        :host_notification_options => 'd,u,r,f,s',
        :service_notification_options => 'w,u,c,r,f',
        :host_notifications_enabled => 1,
        :service_notifications_enabled => 1
      }.merge(params)
      
      options.each do |key, value|
        method = (key.to_s + "=").to_sym
        if self.respond_to?(method)
          self.send(method, value)
        end
      end
    end
    
  end
end
