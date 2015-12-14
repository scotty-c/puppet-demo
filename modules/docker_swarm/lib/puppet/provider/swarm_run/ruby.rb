require 'socket'
require 'resolv'

Puppet::Type.type(:swarm_run).provide(:ruby) do
  desc "Support to run conatiners on your cluster"
  
  mk_resource_methods

  commands :docker => "docker"   
  
  def interface
    hostname = Socket.gethostname
    IPSocket.getaddress(hostname) 
  end

  def docker_run 
    ['-H', "tcp://#{interface}:2376", 'run', '-p', "#{resource[:ports]}", '-d', '--name', "#{resource[:name]}", "#{resource[:image]}"] 
  end
   
  def exists?
    Puppet.info("checking if conatiner is running")
      d = %x(docker -H tcp://#{interface}:2376 ps | grep #{resource[:name]} | grep -v grep)
      ! d.length.eql? 0
   end
 
   def create
     Puppet.info("running container on Swarm Cluster")
     p = fork {docker *docker_run}
     Process.detach(p)
   end

   def destroy
     Puppet.info("Stoping container")
     %x(docker -H tcp://#{interface}:2376 rm -f #{resource[:name]} )
   end
 end
