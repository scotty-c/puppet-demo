require 'rake'

require 'rubygems'
require 'puppetlabs_spec_helper/rake_tasks'
require 'rspec/core/rake_task'
require 'puppet-lint'

PuppetLint.configuration.send('disable_autoloader_layout')

RSpec::Core::RakeTask.new(:ci) do |task|
    task.rspec_opts = "--format JUnit --out junit.xml"
end

task :ci => :spec_prep
