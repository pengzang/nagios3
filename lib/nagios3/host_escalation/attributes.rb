################################################################################
# Author: Brian J Reath
# Date: April 8, 2010
#
# Copyright (c) CCI Systems, Inc. 2010
################################################################################

module Nagios3
  class HostEscalation
    module Attributes
    
      def self.included(klass)
         klass.extend(ClassMethods)
       end
    
      module ClassMethods
      end
    
    end
  end
end
