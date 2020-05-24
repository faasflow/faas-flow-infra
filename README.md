# faas-flow-infra

Faas-Flow infra provides the **kubernetes** and swarm deployment resources for
[faas-flow](https://github.com/s8sg/faas-flow/) dependencies.

## Infra Components

* [Minio](https://min.io): used as DataStore backend;
* [Consul](https://www.consul.io): used as StateStore backend;
* [Jaeger](https://www.jaegertracing.io): used as Tracing backend.

## Getting Started

First clone the repo

```bash
git clone https://github.com/s8sg/faas-flow-infra.git
cd faas-flow-infra
```

### Deploy in Kubernetes

Prerequisites:

* [Helm](https://helm.sh/docs/intro/install/)
* [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

```bash
./deploy_helm_chart.sh
```

#### Manual Deployment

To deploy the components with official helm charts follow this
[guide](./manual_k8.md)

### Deploy in Docker Swarm

Prerequisites:

* [Docker Swarm](https://docs.docker.com/engine/reference/commandline/swarm_init/)

To deploy [initialize the cluster](https://docs.docker.com/engine/swarm/swarm-mode/)
and run:

```bash
./deploy_docker_stack.sh
```

## Consuming the Services

Once deployed components will be available as

|Item|Swarm URL|Kubernets URL|
|---|---|---|
|StateStore|`consul:8500`|`consul.faasflow:8500`|
|DataStore|`minio:9000`|`minio.faasflow:9000`|
|EventManager Agent|`jaegertracing:5775`|`jaeger.faasflow:5775`|
|EventManager Query|`jaegertracing:16686`|`jaeger.faasflow:16686`|
