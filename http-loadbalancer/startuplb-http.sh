#! /bin/bash
#!/bin/bash
# Http Load Balancer GCP Script
export PROJECT=$(gcloud config get-value project)
gcloud config set compute/zone us-central1-a

gcloud create template http-loadbalancer --project=$PROJECT --set-env-vars=PROJECT=$PROJECT --set-env-vars=LOCATION=us-central1 

gcloud compute instance-groups managed create lb-backend-group \
   --template=lb-backend-template --size=2 --zone=us-central1-a

gcloud compute firewall-rules create fw-allow-health-check \
    --network=default \
    --action=allow \
    --direction=ingress \
    --source-ranges=130.211.0.0/22,35.191.0.0/16 \
    --target-tags=allow-health-check \
    --rules=tcp:80
gcloud compute addresses create lb-ipv4-1 \
    --ip-version=IPV4 \
    --global
gcloud compute addresses describe lb-ipv4-1 \
    --format="get(address)" \
    --global
gcloud compute health-checks create http http-basic-check \
    --port 80
gcloud compute backend-services create web-backend-service \
    --protocol=HTTP \
    --port-name=http \
    --health-checks=http-basic-check \
    --global
gcloud compute backend-services add-backend web-backend-service \
    --instance-group=lb-backend-group \
    --instance-group-zone=us-central1-a \
    --global
gcloud compute url-maps create web-map-http \
    --default-service web-backend-service
gcloud compute target-http-proxies create http-lb-proxy \
    --url-map web-map-http
gcloud compute forwarding-rules create http-content-rule \
    --address=lb-ipv4-1\
    --global \
    --target-http-proxy=http-lb-proxy \
    --ports=80

