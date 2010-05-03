$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'spec'
require 'nagios3'

Nagios3.configure do |c|
  tmp_path = File.join(File.dirname(__FILE__), '..', 'tmp')
  
  c.hosts_path = File.join(tmp_path, 'hosts.cfg')
  c.services_path = File.join(tmp_path, 'services.cfg')
  c.contacts_path = File.join(tmp_path, 'contacts.cfg')
  c.host_escalations_path = File.join(tmp_path, 'host_escalations.cfg')
  c.service_escalations_path = File.join(tmp_path, 'service_escalations.cfg')
  c.time_periods_path = File.join(tmp_path, 'time_periods.cfg')
  
  c.status_path = File.join(tmp_path, 'status.dat')
  c.object_path = File.join(tmp_path, 'objects.cache')
end
