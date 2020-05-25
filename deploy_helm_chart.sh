#!/bin/sh

# Check if helm is installed
if ! [ -x "$(command -v helm)" ]; then
  echo 'Unable to find helm command, please install Helm (https://github.com/helm/charts) and retry' >&2
  exit 1
fi

# Check if kubectl is installed
if ! [ -x "$(command -v kubectl)" ]; then
  echo 'Unable to find kubectl command, please install kubectl (https://kubernetes.io/docs/tasks/tools/install-kubectl/) and retry' >&2
  exit 1
fi

# Create namespace faasflow if doesn't exists
echo "Creating Namespace (faasflow) if doesn't exist"
[ ! "$(kubectl get namespace | grep faasflow)" ] && kubectl create namespace faasflow

# Secrets should be created for minio access.
echo "Attempting to create credentials for minio.."
SECRET_KEY=$(head -c 12 /dev/urandom | shasum| cut -d' ' -f1)
ACCESS_KEY=$(head -c 12 /dev/urandom | shasum| cut -d' ' -f1)

kubectl create secret generic -n openfaas-fn \
 s3-secret-key --from-literal s3-secret-key="$SECRET_KEY"
kubectl create secret generic -n openfaas-fn \
 s3-access-key --from-literal s3-access-key="$ACCESS_KEY"
if [ $? = 0 ];
then
    echo "[Minio Credentials]\n Secret Key: $SECRET_KEY \n Access Key: $ACCESS_KEY"
else
    echo "[Minio Credentials]\n already exist, not creating"
fi

echo "Deploying faas-flow-infra chart"
helm install faas-flow-infra chart/faas-flow-infra --namespace faasflow --set minio.accessKey=$ACCESS_KEY,minio.secretKey=$SECRET_KEY
