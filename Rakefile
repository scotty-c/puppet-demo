require "rake"
require 'bundler'
Bundler.require(:rake)
require 'rake/clean'
 

desc "Executes Vagrant up"
task :build do       
    def execute(command)
      puts command
      system command
    end   
      execute "vagrant up"
end




