# Deploy in Kubernets

For deploying in kubernets Faas-Flow Infra uses helm charts for the defaults

## Create namespace

Create namespace for faas-flow infra components

```bash
kubectl create namespace faasflow
```

## Deploy minio (Default DataStore)

Minio is used as the default DataStore in FaaSFlow

Generate secrets for Minio:

```sh
SECRET_KEY=$(head -c 12 /dev/urandom | shasum| cut -d' ' -f1)
ACCESS_KEY=$(head -c 12 /dev/urandom | shasum| cut -d' ' -f1)
```

Store the secrets in Kubernetes:

```sh
kubectl create secret generic -n faasflow-fn \
    s3-secret-key --from-literal s3-secret-key="$SECRET_KEY"
kubectl create secret generic -n faasflow-fn \
    s3-access-key --from-literal s3-access-key="$ACCESS_KEY"
```

Install Minio with helm:

```sh
helm install --name minio --namespace faasflow \
    --set accessKey=$ACCESS_KEY,secretKey=$SECRET_KEY \
    --set replicas=1,persistence.enabled=false,service.port=9000,service.type=NodePort \
    stable/minio
```

The DNS address for minio will be `minio.faasflow:9000`.

## Deploy Consul (Default StateStore)

Consul is used as the default StateStore in FaaSFlow.

Install Consul with helm:

```sh
helm install --name consul --namespace faasflow stable/consul
```

The DNS address for consul will be `consul.faasflow:8500`

## Deploy Jaeger for Tracing

Jaeger is used as a tracing backend by the FaaSFlow

Install Jaeger with helm:

```sh
helm install incubator/jaeger --name jaegertracing --namespace faasflow \
    --set cassandra.config.max_heap_size=1024M \
    --set cassandra.config.heap_new_size=256M --set cassandra.resources.requests.memory=2048Mi \
    --set cassandra.resources.requests.cpu=0.4 --set cassandra.resources.limits.memory=2048Mi \
    --set cassandra.resources.limits.cpu=0.4
```

The DNS address for jaeger will be `jaegertracing.faasflow:16686`
