
gcloud compute --project=qwiklabs-gcp-03-6332554bce4f firewall-rules create fw-allow-health-checks --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:80 --source-ranges=130.211.0.0/22,35.191.0.0/16 --target-tags=allow-health-checks

while [ -z "$RESULT" ] ;  do    echo "Waiting for Load Balancer";   sleep 5;   RESULT=$(curl -m1 -s $LB_IP | grep Apache); done

ab -n 500000 -c 1000 http://$LB_IP
