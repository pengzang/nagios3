lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'rubygems'
require 'nagios3/version'

# RSpec tasks
desc 'Run examples'
task :rspec do
  system "cd spec && rspec *_spec.rb"
end

# RubyGem tasks
desc 'Build the gem'
task :build do
  system "gem build nagios3.gemspec"
end

desc 'Install the gem locally'
task :install => :build do
  system "gem install nagios3-#{Nagios3::VERSION}"
end

desc 'Push the gem to gemcutter'
task :release => :build do
  system "gem push nagios3-#{Nagios3::VERSION}"
end

task :default => :rspec
