Gem::Specification.new do |s|
  s.name = "nagios3"
  s.version = "0.5.2"
  s.summary = "Nagios3 management gem"
  
  s.authors = [ "Brian Reath" ]
  s.date = Time.now.strftime('%Y-%m-%d')
  s.email = ["brian.reath@ccisystems.com"]
  
  s.files = %w(README.markdown Rakefile LICENSE)
  s.files += Dir.glob("examples/**/*")
  s.files += Dir.glob("lib/**/*")
  s.files += Dir.glob("spec/**/*")
  
  s.homepage = "http://github.com/bjreath/nagios3"
  s.rubyforge_project = "nagios3"
  s.rubygems_version = "1.3.6"
  if s.respond_to? :required_rubygems_version=
    s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6")
  end
  
  s.add_development_dependency "rspec"
  
  s.description = <<description
    Ruby Gem to manage a Nagios3 instance"
description
end
