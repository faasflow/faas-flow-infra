# faas-flow-infra
Faas-Flow infra provides the **kubernets** is and swarm deployment resources for faas-flow dependencies

## Infra Components
> [Minio](https://min.io)             [DataStore backend]  
> [Consul](https://www.consul.io)      [StateStore backend]  
> [Jaeger](https://www.jaegertracing.io) [Tracing backend]   


## Getting Started 
First clone the repo
```bash
git clone https://github.com/s8sg/faas-flow-infra.git
cd faas-flow-infra
```

### Deploy in Kubernets

#### Prerequisite 
> [Helm](https://helm.sh/docs/intro/install/)    
> [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)     

##### Install the helm CLI/client

Instructions for latest Helm install

* On Linux and Mac/Darwin:
```sh
curl "https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get" | bash
```
* Or via Homebrew on Mac:
```sh
brew install kubernetes-helm
```
##### Install tiller

* Create RBAC permissions for tiller

```sh
kubectl -n kube-system create sa tiller \
  && kubectl create clusterrolebinding tiller \
  --clusterrole cluster-admin \
  --serviceaccount=kube-system:tiller
```

* Install the server-side Tiller component on your cluster

```sh
helm init --skip-refresh --upgrade --service-account tiller
```
   
#### Deploy the Helm Chart
```bash
./deploy_helm_chart.sh
```

#### Manual Deployment   

To deploy the components with official helm charts follow this [guide](./manual_k8.md) 


### Deploy in Docker Swarm
#### Prerequisite 
> [Docker Swarm](https://docs.docker.com/engine/reference/commandline/swarm_init/)   
  
To deploy in swarm docker swarm need to installed and the targeted node need to have swarm cluster initialized. To initialize a swarm cluster follow this guide: https://docs.docker.com/engine/swarm/swarm-mode/.    
    
#### Deploy the Stack
```bash
./deploy_docker_stack.sh
```

## Consuming the Services

Once deployed components will be available as


 |Item|Swarm URL|Kubernets URL|
 |---|---|---|
 |StateStore|`consul:8500`|`consul.faas-flow-infra:8500`|
 |DataStore|`minio:9000`|`minio.faas-flow-infra:9000`|
 |EventManager Agent|`jaegertracing:5775`|`jaegertracing.faas-flow-infra:5775`|
 |EventManager Query|`jaegertracing:16686`|`jaegertracing.faas-flow-infra:16686`|



