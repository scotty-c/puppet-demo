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

  def port
    ports = []  
    if (resource[:ports]).length > 0
      (resource[:ports]).each do |a|
        ports << a.to_s
      end
    end
    x = [] 
    ports.flatten.each do |p| 
      if p.to_i > 0
        p.insert(0, '--publish=')
      else
       return []
      end
   end
 end

 def docker_run  
    name = (resource[:name])
    image = (resource[:image])
    volume = (resource[:volume])
    volume_driver = (resource[:volume_driver])
    volumes_from = (resource[:volumes_from])
    network = (resource[:network])
    log_driver = (resource[:log_driver])
    log_opt = (resource[:log_opt])
    link = (resource[:link])
    label = (resource[:label])
    ports = ''
      port.each do | pp |
      ports << pp + ' '
     end
    run = ['-H', "tcp://#{interface}:2376", 'run', '-v', "#{volume}", '--volume-driver=', "#{volume_driver}",
         '--volumes-from=', "#{volumes_from}", '--link', "#{link}", '--log-driver=', "#{log_driver}", '--log-opt=', "#{log_opt}", 
         '--label=', "#{label}", '--net=', "#{network}", ports, '-d', '--name', "#{name}", "#{image}"] 

    if volume.to_s.strip.length == 0 then run.delete("-v")
      end 
    if volume_driver.to_s.strip.length == 0 then run.delete("--volume-driver=")
      end
    if volumes_from.to_s.strip.length == 0 then run.delete("--volumes-from=")
      end           
    if link.to_s.strip.length == 0 then run.delete("--link")
      end
    if log_driver.to_s.strip.length == 0 then run.delete("--log-driver=")
      end             
    if log_opt.to_s.strip.length == 0 then run.delete("--log-opt=")
      end             
    if network.to_s.strip.length == 0 then run.delete("--net=")
      end             
    if label.to_s.strip.length == 0 then run.delete("--label=")
      end             
    run.reject { |item| item.nil? || item == '' } 
    str = ''
    run.each do |m|
      str << m.to_s + ' ' 
    end
    s = str.gsub('= ', '=')
    t =  s.gsub(/\s+/, ' ')
    t.rstrip.split
  end
  
  def exists?
    Puppet.info("checking if conatiner is running")
      d = %x(docker -H tcp://#{interface}:2376 ps | grep #{resource[:name]} | grep -v grep)
      ! d.length.eql? 0
   end
 
   def create
     Puppet.info("running container on swarm cluster")
      p = fork {docker *docker_run}
      Process.detach(p)
   end

   def destroy
     Puppet.info("stoping container")
     %x(docker -H tcp://#{interface}:2376 rm -f #{resource[:name]} )
   end
 end