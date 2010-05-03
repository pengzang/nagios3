################################################################################
# Author: Brian J Reath
# Date: April 7, 2010
#
# Copyright (c) CCI Systems, Inc. 2010
################################################################################

require 'nagios3/host/attributes'
require 'nagios3/host/persistence'
require 'nagios3/host/format'

module Nagios3
  class Host
    
    include Nagios3::Host::Attributes
    include Nagios3::Host::Format
    include Nagios3::Host::Persistence
    
    def initialize(params = {})
      options = {
        :use => 'generic-host'
      }.merge(params)
      
      options.each do |key, value|
        method = (key.to_s << "=").to_sym
        if self.respond_to?(method)
          self.send(method, value)
        end
      end
    end
    
  end
end
