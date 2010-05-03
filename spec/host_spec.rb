require 'spec_helper'

describe Nagios3::Host do 
  
  before(:all) do
    @supported_fields = [
      :host_name, :alias, :address, :parents, :host_groups, :contacts,
      :contact_groups, :check_command, :check_interval, :retry_interval,
      :max_check_attempts, :check_period, :first_notification_delay, 
      :notification_interval, :notification_period, :notification_options
    ]

    @custom_fields = [:id, :snmp_version, :snmp_community]
  end
  
  before(:each) do
    @host = Nagios3::Host.new(:id => 1)
  end
  
  it 'should have the supported Nagios3 host fields' do
    @supported_fields.each { |field| @host.respond_to?(field).should be(true) }
  end
  
  it 'should have our custom Nagios3 host fields' do
    @custom_fields.each { |field| @host.respond_to?(field).should be(true) }
  end
  
  it 'should be in the UP state' do
    host = Nagios3::Host.find(67)
    @host.state.should == "UP"
  end
  
  it 'should save the host' do
    @host.host_name = 'gar-cmts'
    @host.save
    @host.destroy
  end
  
  it 'should update the host' do
    
  end
  
  it 'should destroy the host' do
    @host.id = 5
    @host.host_name = 'gar-cmts'
    @host.save
    Nagios3::Host.configured?(@host.id).should be(true)
    @host.destroy
    Nagios3::Host.configured?(@host.id).should be(false)
  end
  
  it 'should find a saved host' do
    host = Nagios3::Host.find(67)
    host.should_not be(nil)
  end
  
  it 'should list all saved hosts' do
    hosts = Nagios3::Host.find(:all)
    hosts.size.should == 2
  end
  
end