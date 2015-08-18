# Puppet Meetup Demo
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
This will build a demo environment of 3 boxes in Docker Swarm cluster and 1 Swarm Manager. It also configurers Conul so we can monitor the cluster and contianers on the cluster.
We use weave to network between the containers and Docker compose to roll out the apps (Jenkins, Nginx, Rabitmq). This is all automated and controlled with Puppet.

Please note that this takes some time to build, almost 40 mins. 

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
