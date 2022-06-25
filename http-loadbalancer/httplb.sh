#!/bin/bash
# Http Load Balancer GCP Script
echo "Creating the load balancer HTTP"

cat << EOF > startup.sh
#! /bin/bash
apt-get update
apt-get install -y nginx
service nginx start
sed -i -- 's/nginx/Google Cloud Platform - '"\$HOSTNAME"'/' /var/www/html/index.nginx-debian.html
EOF

gcloud compute instance-templates create web-server-template \
       --metadata-from-file startup-script=startup.sh \
       --network nucleus-vpc \
       --machine-type g1-small \
       --region us-east1

gcloud compute instance-groups managed create lb-backend-group \
   --template=lb-backend-template --size=2 --zone=us-central1-a

gcloud compute firewall-rules create allow-tcp-rule-457 \
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
