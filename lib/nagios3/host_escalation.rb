################################################################################
# Author: Brian J Reath
# Date: April 8, 2010
#
# Copyright (c) CCI Systems, Inc. 2010
################################################################################

require 'nagios3/host_escalation/attributes'
require 'nagios3/host_escalation/persistence'
require 'nagios3/host_escalation/format'

module Nagios3
  class HostEscalation
    
    include Nagios3::HostEscalation::Attributes
    include Nagios3::HostEscalation::Format
    include Nagios3::HostEscalation::Persistence
    
    def initialize(params = {})
      options = {}.merge(params)
      
      options.each do |key, value|
        method = (key.to_s << "=").to_sym
        if self.respond_to?(method)
          self.send(method, value)
        end
      end
    end
    
  end
end