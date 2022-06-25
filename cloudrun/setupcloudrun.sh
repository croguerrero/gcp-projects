#!/bin/bash
# Setup the Cloud Run service
gcloud services enable run.googleapis.com
gcloud config set compute/region us-central1
export PROJECT=$(gcloud config get-value project)
LOCATION="us-central1"
mkdir helloworld && cd helloworld

gcloud builds submit --tag gcr.io/$PROJECT/helloworld:v1
gcloud container images list
docker run -d -p 8080:8080 gcr.io/$PROJECT/helloworld
gcloud run deploy --image gcr.io/$PROJECT/helloworld --allow-unauthenticated --region=$LOCATION