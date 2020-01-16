### Deploy in Kubernets
For deploying in kubernets Faas-Flow Infra uses helm charts for the defaults    

#### Pre-reqs:
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

> Note: this step installs a server component in your cluster. It can take anywhere between a few seconds to a few minutes to be installed properly. You should see tiller appear on: `kubectl get pods -n kube-system`.

#### Create namespace
Create namespace for faas-flow infra components 
```
kubectl create namespace faasflow
```

#### Deploy minio (Default DataStore)
Minio is used as the default DataStore in FaaSFlow    
   
* Generate secrets for Minio
```sh
SECRET_KEY=$(head -c 12 /dev/urandom | shasum| cut -d' ' -f1)
ACCESS_KEY=$(head -c 12 /dev/urandom | shasum| cut -d' ' -f1)
```
* Store the secrets in Kubernetes
```sh
kubectl create secret generic -n faasflow \
 s3-secret-key --from-literal s3-secret-key="$SECRET_KEY"
kubectl create secret generic -n faasflow \
 s3-access-key --from-literal s3-access-key="$ACCESS_KEY"
```

* Install Minio with helm
```sh
helm install --name minio --namespace faasflow \
   --set accessKey=$ACCESS_KEY,secretKey=$SECRET_KEY \
   --set replicas=1,persistence.enabled=false,service.port=9000,service.type=NodePort \
  stable/minio
```

* The DNS address for minio will be `minio.faasflow:9000`

#### Deploy Consul (Default StateStore)
Consul is used as the default StateStore in FaaSFlow     
   
* Install Consul with helm
```sh
helm install --name consul --namespace faasflow stable/consul
```

* The DNS address for consul will be `consul.faasflow:8500`

#### Deploy Jaeger for Tracing
Jaeger is used as a tracing backend by the FaaSFlow 

* Install Jaeger with helm
```sh
helm install incubator/jaeger --name jaegertracing --namespace faasflow \
     --set cassandra.config.max_heap_size=1024M \
     --set cassandra.config.heap_new_size=256M --set cassandra.resources.requests.memory=2048Mi \
     --set cassandra.resources.requests.cpu=0.4 --set cassandra.resources.limits.memory=2048Mi \
     --set cassandra.resources.limits.cpu=0.4
```
   
* The DNS address for jaeger will be `jaegertracing.faasflow:16686`
