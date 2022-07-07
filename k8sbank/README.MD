export LOCATION="us-central1"
export ZONE="us-central1-a"
export PROJECT=$(gcloud config get-value project)
git clone https://github.com/GoogleCloudPlatform/bank-of-anthos

gcloud beta container clusters create bank-of-anthos \
    --project=${PROJECT} --zone=${ZONE} \
    --machine-type=e2-standard-2 --num-nodes=4 \
    --monitoring=SYSTEM --logging=SYSTEM,WORKLOAD --subnetwork=default \
    --tags=bank-of-anthos --labels csm=true

gcloud container clusters get-credentials bank-of-anthos \
    --project=${PROJECT} --zone=${ZONE}

# Create secret 
kubectl apply -f ./extras/jwt/jwt-secret.yaml
kubectl apply -f ./kubernetes-manifests

kubectl get service frontend | awk '{print $4}'

