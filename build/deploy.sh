#!/bin/bash
set -e

echo "Switching kubectl context..."
kubectl config use-context "$KUBECONTEXT"

echo "Verifing cluster access..."
kubectl cluster-info 
if [ ! $? -eq 0 ];
then
  echo "Issue access to the cluster."
  exit 2
fi

echo "Creating the namespace..."
if [[ -z $NAMESPACE ]]
then
  NAMESPACE=`echo "heartbeat-"$BRANCH`
fi
echo "Namespace: $NAMESPACE"
kubectl create namespace "$NAMESPACE"

if [[ -z "$STORAGECLASS" ]]
then
  STORAGECLASS="longhorn"
fi
echo "Storageclass: $STORAGECLASS"

if [[ -z "$DB_USER" ]]
then
  DB_USER="heartbeat"
fi
echo "DB Username: $DB_USER"

if [[ -z "$DB_NAME" ]]
then
  DB_NAME="heartbeat"
fi
echo "DB Name: $DB_NAME"

if [[ -z "$Prometheus_Namespace" ]]
then
  Prometheus_Namespace="cattle-prometheus"
fi
echo "Prometheus Namespace: $Prometheus_Namespace"

echo "Deploying Database..."
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm install --namespace "$NAMESPACE" mariadb bitnami/mariadb-galera \
--set global.storageClass = "$STORAGECLASS" \
--set db.user = "$DB_USER" \
--set db.name = "$DB_NAME" \
--set metrics.enabled = true \
--set metrics.serviceMonitor.enabled = true \
--set metrics.serviceMonitor.namespace = "$Prometheus_Namespace" \
--set metrics.serviceMonitor.interval = 5s \
--set metrics.prometheusRules.enabled = true