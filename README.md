# faas-flow-infra
Faas-Flow infra provides the **kubernets** is and swarm deployment resources for faas-flow dependencies

### Infra Components
> [Minio](https://min.io)             [DataStore backend]  
> [Consul](https://www.consul.io)      [StateStore backend]  
> [Jaeger](https://www.jaegertracing.io) [Tracing backend]   


### Getting Started 
First clone the repo
```bash
git clone https://github.com/s8sg/faas-flow-infra.git
cd faas-flow-infra
```

#### Deploy in Kubernets
Prerequisite 
> [Helm](https://helm.sh/docs/intro/install/)    
> [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)     
   
Deploy the Helm Chart
```bash
./deploy_helm_chart.sh
```

#### Deploy in Docker Swarm
Prerequisite 
> [Docker Swarm](https://docs.docker.com/engine/reference/commandline/swarm_init/)   
    
Deploy the Stack
```bash
./deploy_docker_stack.sh
```

### Consuming the Services

The components will be available as


 |Item|Swarm URL|Kubernets URL|
 |---|---|---|
 |StateStore|`consul:8500`|`consul.faas-flow-infra:8500`|
 |DataStore|`minio:9000`|`minio.faas-flow-infra:9000`|
 |EventManager Agent|`jaegertracing:5775`|`jaegertracing.faas-flow-infra:5775`|
 |EventManager Query|`jaegertracing:16686`|`jaegertracing.faas-flow-infra:16686`|



