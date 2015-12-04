# PuppetConf Demo
```
Prerequisites:
- Vagrant
- Ruby
```


# Install dependencies
```
git clone to a new directory
cd that directory
vagrant up
```
This will build a demo environment of 3 boxes in Docker Swarm cluster and 2 Swarm Managers. It also configures Conul so we can monitor the cluster and containers on the cluster.
We use the native Docker network between the containers and Docker compose to roll out the apps (Jenkins, Nginx, Rabitmq). This is all automated and controlled with Puppet.
I have updated my Golang and swarm modules to decrease the build times (dramatically !!!)

# URL
consul
````
127.0.0.1:9500
````
Jenkins
````
127.0.0.1:9080
````
Nginx
`````
127.0.0.1:5080
````
Rabitmq
````
127.0.0.1:9083
````

# Commands

Here are a few interesting commands to look at what is happening inside the swarm cluster. ````vagrant ssh swarm-master-01```` or ````vagrant ssh swarm-master-01````

Info
````
docker -H tcp://172.17.8.104:2376 info
`````  

Docker ps
```` 
docker -H tcp://172.17.8.104:2376 ps
````

On any of the other host run ````docker network ls```` to see the container network