Puppet::Type.newtype(:swarm_cluster) do
    @doc = "Runs Docker Swarm"

    ensurable do
      defaultvalues
      defaultto :present
    end

    newparam(:name, :namevar => true) do
      desc "Just a human refernece"  
    end
    
    newparam(:backend) do
      desc "Should be either consul, etcd, mesos or zookepper"
      newvalues(:etcd, :consul, :zk, :swarm, :mesos)
      defaultto :swarm
    end

    newparam(:cluster_type) do
      desc "This sets the cluster command of join, manage or create"
      newvalues(:join, :manage, :create)
      defaultto :create
    end  

    newparam(:address) do
      desc "Should be the address of consul, etcd, mesos or zookepper cluster"
    end
    
    newparam(:port) do
      desc "Should be the port of consul, etcd, mesos or zookepper"  
    end 
    
    newparam(:advertise) do
      desc "Address to advertise for the Swarm replication manager" 
    end

    newparam(:path) do
      desc "Should be the path of the consul, etcd, mesos or zookepper KV"
    end
end