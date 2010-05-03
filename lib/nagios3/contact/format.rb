################################################################################
# Author: Brian J Reath
# Date: April 8, 2010
#
# Copyright (c) CCI Systems, Inc. 2010
################################################################################

module Nagios3
  class Contact
    module Format
      
      def to_config
        config = "define contact {\n"
        config << "\tcontact_name #{self.name}\n"
        config << "\talias #{self.alias}\n"
        config << "\tcontactgroups #{self.groups}\n" unless self.groups.nil?
        config << "\temail #{self.email}\n" unless self.email.nil?
        config << "\tpager #{self.pager}\n" unless self.pager.nil?
        config << "\taddress1 #{self.mobile}\n" unless self.mobile.nil?
        config << "\thost_notification_commands #{self.host_notification_commands}\n"
        config << "\thost_notification_period #{self.host_notification_period}\n"
        config << "\thost_notification_options #{self.host_notification_options}\n"
        config << "\thost_notifications_enabled #{self.host_notifications_enabled}\n"
        config << "\tservice_notification_commands #{self.service_notification_commands}\n"
        config << "\tservice_notification_period #{self.service_notification_period}\n"
        config << "\tservice_notification_options #{self.service_notification_options}\n"
        config << "\tservice_notifications_enabled #{self.service_notifications_enabled}\n"
        config << "\t_ID #{self.id}\n"
        config << "}\n"
      end
      
    end
  end
end
