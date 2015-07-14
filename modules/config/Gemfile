source "https://rubygems.org"

gem 'rake', :group => [:development, :test]

group :development do
    gem 'pry'
    gem 'puppet-lint'
end

group :test do
    gem 'puppet', "~> 3.4"
    gem 'puppetlabs_spec_helper'
    gem 'rspec', "< 2.99"
    gem 'rspec-puppet'
    gem 'yarjuf' #Rspec Junit formatter
end
