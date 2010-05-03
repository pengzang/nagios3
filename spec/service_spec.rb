require 'spec_helper'

describe Nagios3::Service do
  
  before(:each) do
    @service = Nagios3::Service.new
  end
  
  it 'should be in an UNKNOWN state' do
    @service.state.should == "UNKNOWN"
  end
  
end