#!/bin/bash

#DEploy a GCP bucket

export LOCATION="us-central1"
export PROJECT=$(gcloud config get-value project)

#gsutil mb -l $LOCATION gs://$PROJECT --storage-class "regional" -c "COLDLINE"
    gsutil mb -p $PROJECT -c "COLDLINE" -l $LOCATION -b on gs://$PROJECT

gsutil cp gs://cloud-training/gcpfci/my-excellent-blog.png my-excellent-blog.png

gsutil cp my-excellent-blog.png gs://$PROJECT/my-excellent-blog.png

#MOdify access permissions
gsutil acl ch -u allUsers:R gs://$PROJECT/my-excellent-blog.png