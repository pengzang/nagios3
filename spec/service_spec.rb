require 'spec_helper'

describe Nagios3::Service do
  
  before(:each) do
    @service = Nagios3::Service.new(:id => 1)
  end
  
  it 'should be in an UNKNOWN state' do
    @service.state.should == "UNKNOWN"
  end
  
  it 'should save the service' do
    @service.host_name = 'gar-cmts'
    @service.description = 'SNMP Check'
    @service.save
    Nagios3::Service.configured?(@service.id).should be(true)
    @service.destroy
    Nagios3::Service.configured?(@service.id).should be(false)
  end
  
end