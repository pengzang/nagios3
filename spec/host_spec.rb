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
    File.open(Nagios3.hosts_path, "w") { |f| }
    @host = Nagios3::Host.new
  end
  
  it 'should have the supported Nagios3 host fields' do
    @supported_fields.each { |field| @host.respond_to?(field).should be(true) }
  end
  
  it 'should have our custom Nagios3 host fields' do
    @custom_fields.each { |field| @host.respond_to?(field).should be(true) }
  end
  
  it 'should be in the UP state' do
    @host.host_name = 'test-cmts'
    @host.state.should == "UP"
  end
  
  it 'should save the host' do
    @host.host_name = 'gar-cmts'
    @host.save
  end
  
  it 'should update the host' do
    
  end
  
  it 'should destroy the host' do
    @host.host_name = 'gar-cmts'
    @host.save
    Nagios3::Host.configured?(@host.host_name).should be(true)
    
    @host.destroy
    Nagios3::Host.configured?(@host.host_name).should be(false)
  end
  
  it 'should find a saved host' do
    host = Nagios3::Host.find('test-cmts')
    host.should_not be(nil)
  end
  
  it 'should list all saved hosts' do
    hosts = Nagios3::Host.find(:all)
    hosts.size.should == 1
  end
  
end