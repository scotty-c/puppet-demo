# PuppetConf Demo
```
Prerequisites:
- Vagrant
- Ruby
```
## This is a full re-write of the environment.

# Install dependencies
```
git clone to a new directory
cd that directory
vagrant up
```
This will build a demo environment of 3 boxes in Docker Swarm cluster and 2 Swarm Masters. It also configurers Conul so we can monitor the cluster and contianers on the cluster.
This is all automated and controlled with Puppet. The Swarm master will pick a node to deploy the contianers on. So you can check the consul gui, ping the service name from any of the 5 boxes or logon to one of the swarm masters and run ````docker -H tcp://172.17.8.114:2376 ps````. Once you have the ip of the box, you can access the app on the forwarded port from the ````server.yaml````. 

#Update 
The demo now builds a fuly operational ELK stack https://www.elastic.co/ You can find where all the containers are scheduled through the Consul ui
It also adds enhanced checks to Consul to monitor the Swam-masters.

# URL
consul
````
127.0.0.1:9501
````

# Commands
Here are a few interesting commands to look at what is happening inside the swarm cluster. ````vagrant ssh master-01```` or ````vagrant ssh master-02````


Info
````
docker -H tcp://172.17.8.114:2376 info
`````  

Docker ps
```` 
docker -H tcp://172.17.8.114:2376 ps
````

On any of the other host run ````docker network ls```` to see the container networks

