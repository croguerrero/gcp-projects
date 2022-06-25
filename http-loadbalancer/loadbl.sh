#!/bin/bash
# Load Balancer GCP Script
export PROJECT=$(gcloud config get-value project)
gcloud config set compute/zone us-central1-a
gcloud config set compute/region us-central1
name="www"

function setup () { gcloud compute instances create $name$i \
  --image-family debian-9 \
  --image-project debian-cloud \
  --zone us-central1-a \
  --tags network-lb-tag \
  --metadata startup-script="#! /bin/bash
    sudo apt-get update
    sudo apt-get install apache2 -y
    sudo service apache2 restart
    echo '<!doctype html><html><body><h1>www$i</h1></body></html>' | tee /var/www/html/index.html"
}

for i in {1..3}
    do
        setup
        gcloud compute instances add-tags $name --tags www$i
    done

gcloud compute firewall-rules create www-firewall-network-lb --target-tags network-lb-tag --allow tcp:80
gcloud compute addresses create network-lb-ip-1 --region us-central1
gcloud compute http-health-checks create basic-check
gcloud compute target-pools create www-pool --region us-central1 --http-health-check basic-check
gcloud compute target-pools add-instances www-pool --instances www1,www2,www3
gcloud compute forwarding-rules create www-rule \
    --region us-central1 \
    --ports 80 \
    --address network-lb-ip-1 \
    --target-pool www-pool
gcloud compute forwarding-rules list
gcloud compute forwarding-rules describe www-rule --region us-central1

while true; do curl -m1 IP_ADDRESS; done # IP_ADDRESS is the IP address of the load balancer 



