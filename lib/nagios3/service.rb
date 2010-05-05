################################################################################
# Author: Brian J Reath
# Date: April 8, 2010
#
# Copyright (c) CCI Systems, Inc. 2010
################################################################################

require 'nagios3/service/attributes'
require 'nagios3/service/persistence'
require 'nagios3/service/format'

module Nagios3
  class Service
    
    include Nagios3::Service::Attributes
    include Nagios3::Service::Format
    include Nagios3::Service::Persistence
    
    def initialize(params = {})
      options = {
        :use => 'generic-service'
      }.merge(params)
      
      options.each do |key, value|
        method = (key.to_s + "=").to_sym
        self.send(method, value) if self.respond_to?(method)
      end
    end
    
  end
end
