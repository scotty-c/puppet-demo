require 'spec_helper'
describe 'docker_swarm' do

let(:facts) { {:osfamily => 'RedHat', :operatingsystemrelease => 'RedHat Linux release 6.5'}}
  
  context 'with defaults for all parameters' do
    it { should contain_class('docker_swarm') }
  end
end
