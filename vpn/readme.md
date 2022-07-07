gcloud compute target-vpn-gateways create vpn-1 --project=qwiklabs-gcp-02-0280ec36ba13 --region=us-central1 --network=vpn-network-1

gcloud compute forwarding-rules create vpn-1-rule-esp --project=qwiklabs-gcp-02-0280ec36ba13 --region=us-central1 --address=35.222.120.72 --ip-protocol=ESP --target-vpn-gateway=vpn-1

gcloud compute forwarding-rules create vpn-1-rule-udp500 --project=qwiklabs-gcp-02-0280ec36ba13 --region=us-central1 --address=35.222.120.72 --ip-protocol=UDP --ports=500 --target-vpn-gateway=vpn-1

gcloud compute forwarding-rules create vpn-1-rule-udp4500 --project=qwiklabs-gcp-02-0280ec36ba13 --region=us-central1 --address=35.222.120.72 --ip-protocol=UDP --ports=4500 --target-vpn-gateway=vpn-1

gcloud compute vpn-tunnels create tunnel1to2 --project=qwiklabs-gcp-02-0280ec36ba13 --region=us-central1 --peer-address=35.233.59.25 --shared-secret=gcprocks --ike-version=1 --local-traffic-selector=0.0.0.0/0 --remote-traffic-selector=0.0.0.0/0 --target-vpn-gateway=vpn-1

gcloud compute vpn-tunnels create vpn-1-tunnel-2 --project=qwiklabs-gcp-02-0280ec36ba13 --region=us-central1 --ike-version=2 --target-vpn-gateway=vpn-1

gcloud compute routes create tunnel1to2-route-1 --project=qwiklabs-gcp-02-0280ec36ba13 --network=vpn-network-1 --priority=1000 --destination-range=10.1.3.0/24 --next-hop-vpn-tunnel=tunnel1to2 --next-hop-vpn-tunnel-region=us-central1

