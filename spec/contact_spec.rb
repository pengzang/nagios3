require 'spec_helper'

describe Nagios3::Contact do
  
  before(:each) do
    @contact = Nagios3::Contact.new(:id => 1)
  end
  
  it 'should save the contact' do
    @contact.name = 'Brian'
    @contact.alias = 'Brian Reath'
    @contact.save
    Nagios3::Contact.configured?(@contact.id).should be(true)
    @contact.destroy
    Nagios3::Contact.configured?(@contact.id).should be(false)
  end
  
  it 'should update the contact' do
    @contact.name = 'Brian'
    @contact.alias = 'Brian Reath'
    @contact.save
    Nagios3::Contact.configured?(@contact.id).should be(true)
    @contact.alias = 'BJ Reath'
    @contact.update
    Nagios3::Contact.configured?(@contact.id).should be(true)
    tmp = Nagios3::Contact.find(@contact.id)
    tmp.alias.should == @contact.alias
    @contact.destroy
    Nagios3::Contact.configured?(@contact.id).should be(false)
  end
  
end