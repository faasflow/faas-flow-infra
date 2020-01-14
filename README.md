# faas-flow-infra
Faas-Flow infra provides the **kubernets** is and swarm deployment resources for faas-flow dependencies

### Infra Components
> [Minio](https://min.io)             [DataStore backend]  
> [Consul](https://www.consul.io)      [StateStore backend]  
> [Jaeger](https://www.jaegertracing.io) [Tracing backend]   


### Getting Started 
First clone the repo as
```sh
git clone https://github.com/s8sg/faas-flow-infra.git
```

#### Deploy in Kubernets
Prerequisite 
> [Helm](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&ved=2ahUKEwix2vKP4oLnAhUlmuYKHfN-A0QQFjAAegQIBhAB&url=https%3A%2F%2Fhelm.sh%2Fdocs%2Fintro%2Finstall%2F&usg=AOvVaw2PPPMiKayB1EbDqpo8gPbY).  
   
Create a new namespace
```
kubectl create namespace faas-flow-infra
```  
    
Deploy the Helm Chart
```
helm install faas-flow-infra chart/faas-flow-infra --namespace faas-flow-infra
```

#### Deploy in Docker Swarm
Prerequisite 
> [Docker Swarm](https://docs.docker.com/engine/reference/commandline/swarm_init/)   
    
Create Minio Secret and Access Key
```
SECRET_KEY=$(head -c 12 /dev/urandom | shasum| cut -d' ' -f1)
ACCESS_KEY=$(head -c 12 /dev/urandom | shasum| cut -d' ' -f1)
echo -n "$SECRET_KEY" | docker secret create s3-secret-key -
echo -n "$ACCESS_KEY" | docker secret create s3-access-key -
```
  
Deploy the Stack
```
docker stack deploy faass-flow-infra -f docker/docker-compose.yaml
```
