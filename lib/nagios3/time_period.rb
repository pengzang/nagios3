################################################################################
# Author: Brian J Reath
# Date: April 8, 2010
#
# Copyright (c) CCI Systems, Inc. 2010
################################################################################

require 'nagios3/time_period/attributes'
require 'nagios3/time_period/persistence'
require 'nagios3/time_period/format'

module Nagios3
  class TimePeriod
    
    include Nagios3::TimePeriod::Attributes
    include Nagios3::TimePeriod::Format
    include Nagios3::TimePeriod::Persistence
    
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
