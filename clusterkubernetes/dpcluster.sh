#!/bin/bash
#Deploy Cluster Kubernetes

export PROJECT=$(gcloud config get-value project)
#gcloud config set compute/zone us-central1-b
gcloud config set compute/region us-central1
echo "Deploying cluster"
echo "Write the name of the cluster" read NAMECLUSTER

gcloud container clusters create $NAMECLUSTER \
          --num-nodes 1 \
          --network cluster-vpc \
          
gcloud container clusters get-credentials $NAMECLUSTER --project=$PROJECT --zone=us-central1-b

do if [ $? -eq 0 ]; then
    echo "Cluster Kubernetes deployed is UP and RUN NODE"
    break 
else
    echo "Cluster Kubernetes deployment is dont installed yet. Wait a moment"
fi  
done

kubectl create deployment hello-server \
          --image=gcr.io/google-samples/hello-app:2.0

kubectl expose deployment hello-server \
          --type=LoadBalancer \
          --port 8082