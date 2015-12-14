Puppet::Type.newtype(:swarm_run) do
    @doc = "Runs Docker Swarm"

    ensurable do
      defaultvalues
      defaultto :present
    end

    newparam(:name, :namevar => true) do
      desc "Application name"  
    end
    
    newparam(:ports) do
      desc "Ports for guest and host. An example would look like 80:80"
    end

    newparam(:image) do
      desc "Docker image to pull"
    end
end
